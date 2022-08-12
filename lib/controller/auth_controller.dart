import 'package:credr/utils/constants.dart';
import 'package:credr/view/home.dart';
import 'package:credr/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final Rx<User?> _user = Rx<User?>(firebaseAuth.currentUser);
  final userid = ''.obs;

  Rx<bool> isLoading = false.obs;
  @override
  void onReady() {
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, onUserChange);
    super.onReady();
  }

  onUserChange(User? user) {
    if (user == null) {
      Get.offAll(() => const SignIn());
    } else {
      Get.offAll(() => const Home());
    }
  }

  // Sign Up methods

  signUpWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      userid.value = email;
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      showMessage('Sign up error', '${e.message}');
      isLoading.value = false;
    }
  }

  signUpWithUsername(String username, String password) async {
    try {
      isLoading.value = true;
      final data = await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (data.docs.isNotEmpty) {
        showMessage('Sign up error', 'Username already exists');
        isLoading.value = false;
        return;
      }
      await firebaseAuth.signInAnonymously();
      final ref = firestore.collection('users').doc();
      await ref.set({
        'username': username,
        'password': password,
      });
      userid.value = username;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showMessage('Sign up error');
    }
  }

  // Sign In methods

  signInWithUsername(String username, String password) async {
    try {
      isLoading.value = true;
      final data = await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (data.docs.isEmpty) {
        showMessage('Sign in error', 'Username is not found');
        isLoading.value = false;
        return;
      } else {
        if (data.docs.first.data()['password'] != password) {
          showMessage('Sign in error', 'Password is incorrect');
          isLoading.value = false;
          return;
        }
      }
      await firebaseAuth.signInAnonymously();
      userid.value = username;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      showMessage('Sign in error');
    }
  }

  signInWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      userid.value = email;
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      showMessage('Sign in error', '${e.message}');
      isLoading.value = false;
    }
  }

  signInWithGoogle() async {
    try {
      isLoading.value = true;
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final u = (await firebaseAuth.signInWithCredential(credential)).user;
      userid.value = u!.email!;
      isLoading.value = false;
    } catch (e) {
      showMessage('Sign in error');

      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  signOut() async {
    try {
      isLoading.value = true;
      await firebaseAuth.signOut();
      GoogleSignIn().signOut();
      userid.value = '';
      isLoading.value = false;
    } catch (_) {
      isLoading.value = false;
      showMessage('Sign out error');
    }
  }

  showMessage(
      [String title = 'Message', String message = 'Something went wrong']) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white,
    );
  }
}

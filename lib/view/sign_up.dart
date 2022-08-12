import 'package:credr/utils/constants.dart';
import 'package:credr/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              greyLight,
              greyDark,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundImage(),
            GradientCircle(size: size.width),
            SizedBox(
              height: size.height,
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            const HeaderText('Sign Up',
                                'Sign up with your username or email'),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 25,
                                  left: 70,
                                  top: 20,
                                ),
                                child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          'Username or Email',
                                          controller: emailController,
                                          corner: RoundedCorner.top,
                                          inputAction: TextInputAction.next,
                                          validator: (res) {
                                            if (res!.isNotEmpty) {
                                              if (res.contains('@')) {
                                                // validating email
                                                if (regExForEmail
                                                    .hasMatch(res)) {
                                                  return null;
                                                } else {
                                                  return 'Enter a valid email';
                                                }
                                              } else {
                                                // validating username
                                                if (res.length < 4) {
                                                  return 'Username requires minimum 4 characters';
                                                }
                                                if (res.length > 15) {
                                                  return 'Maximum 14 characters only allowed';
                                                }
                                                if (regExForUsername
                                                    .hasMatch(res)) {
                                                  return null;
                                                } else {
                                                  return 'Invalid username';
                                                }
                                              }
                                            } else {
                                              return 'Username or email is required';
                                            }
                                          },
                                        ),
                                        const WhiteDivider(),
                                        CustomTextField(
                                          'Password',
                                          controller: passwordController,
                                          inputAction: TextInputAction.next,
                                          isPassword: true,
                                          validator: (res) {
                                            if (res!.isNotEmpty) {
                                              if (res.length < 8) {
                                                return 'Minimum 8 characters required';
                                              }
                                              return null;
                                            } else {
                                              return 'Password is required';
                                            }
                                          },
                                        ),
                                        const WhiteDivider(),
                                        CustomTextField(
                                          'Confirm Password',
                                          controller: confirmPasswordController,
                                          corner: RoundedCorner.bottom,
                                          inputAction: TextInputAction.done,
                                          isPassword: true,
                                          validator: (res) {
                                            if (res!.isNotEmpty) {
                                              if (res !=
                                                  passwordController.text) {
                                                return 'Password are not matching';
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        RoundedButton(
                                          text: 'Sign Up',
                                          onTap: () {
                                            FocusManager.instance.primaryFocus!
                                                .unfocus();
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (emailController.text
                                                  .contains('@')) {
                                                authController.signUpWithEmail(
                                                    emailController.text,
                                                    passwordController.text);
                                              } else {
                                                authController
                                                    .signUpWithUsername(
                                                        emailController.text,
                                                        passwordController
                                                            .text);
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              child: UnderlinedTextButton(
                                'Forget Password',
                                onTap: () {},
                                lineWidth: 130,
                              ),
                            ),
                            const SizedBox(height: 80),
                            const SizedBox(
                              width: double.infinity,
                              child: GreyText(
                                'Social Login can save your valuable time',
                              ),
                            ),
                            const HandDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RoundedButton(
                                  text: 'Google   ',
                                  image: 'assets/google.png',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  onTap: () {
                                    authController.signInWithGoogle();
                                  },
                                ),
                                RoundedButton(
                                  text: 'Facebook',
                                  image: 'assets/fb.png',
                                  backgroundColor: const Color(0xff364b9a),
                                  onTap: () {},
                                )
                              ],
                            ),
                            const SizedBox(height: 24),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BackButton(
                color: Colors.white,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Obx(() {
              return authController.isLoading.value
                  ? LoadingOverlay(size: size)
                  : const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}

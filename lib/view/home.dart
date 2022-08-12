import 'package:credr/utils/constants.dart';
import 'package:credr/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
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
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GreyText(
                        'Welcome Home',
                        fontSize: 30,
                      ),
                    ),
                    Obx(
                      () => GreyText(
                        authController.userid.value,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedButton(
                        text: 'Sign Out',
                        onTap: () {
                          authController.signOut();
                        },
                      ),
                    ),
                  ],
                ),
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

import 'package:credr/utils/constants.dart';
import 'package:credr/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black54,
                        Colors.transparent,
                        Colors.transparent,
                      ]).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Center(child: Image.asset('assets/bg.png'))),
            Positioned(
              right: 60,
              top: -60,
              child: Container(
                width: size.width + 300,
                height: size.width + 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      blueLight,
                      blueLight,
                      blueDark,
                      blueDark,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height,
              child: CustomScrollView(
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
                            const HeaderText('Sign In',
                                'Sign in with your username or email'),
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
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    CustomTextField(
                                      'Username or Email',
                                      corner: RoundedCorner.top,
                                    ),
                                    WhiteDivider(),
                                    CustomTextField(
                                      'Password',
                                    ),
                                    WhiteDivider(),
                                    CustomTextField(
                                      'Confirm Password',
                                      corner: RoundedCorner.bottom,
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    RoundedButton(text: 'Sign In'),
                                  ],
                                )),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: UnderlinedTextButton(
                                'Create Account',
                                onTap: () {},
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
                                  onTap: () {},
                                ),
                                RoundedButton(
                                  text: 'Facebook',
                                  image: 'assets/fb.png',
                                  backgroundColor: const Color(0xff364b9a),
                                  onTap: () {},
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

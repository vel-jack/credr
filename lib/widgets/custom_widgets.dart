import 'package:credr/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.image,
    this.onTap,
  }) : super(key: key);
  final String text;
  final String? image;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: image == null ? 182 : 152,
        height: image == null ? 42 : 37,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: blueDark),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  '$image',
                ),
              ),
            if (image != null)
              const SizedBox(
                width: 10,
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteDivider extends StatelessWidget {
  const WhiteDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 0.3,
    );
  }
}

enum RoundedCorner { top, bottom }

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.hint, {
    Key? key,
    this.controller,
    this.corner,
    this.isPassword = false,
    this.inputAction,
    this.validator,
  }) : super(key: key);
  final TextEditingController? controller;
  final RoundedCorner? corner;
  final String hint;
  final bool isPassword;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xddffffff),
        borderRadius: corner != null
            ? corner == RoundedCorner.top
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
            : null,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        textInputAction: inputAction,
        validator: validator,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          // fontSize: 14,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class UnderlinedTextButton extends StatelessWidget {
  const UnderlinedTextButton(
    this.text, {
    Key? key,
    required this.onTap,
    this.lineWidth = 120,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final double lineWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(right: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: blueDark, // Text colour here
              width: 3.0, // Underline width
            ),
          )),
          child: GreyText(
            text,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class GreyText extends StatelessWidget {
  const GreyText(this.text, {Key? key, this.fontSize = 16}) : super(key: key);
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: greyText,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}

class BlueLine extends StatelessWidget {
  const BlueLine({
    Key? key,
    this.width = 120.0,
  }) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      height: 3.0,
      width: width,
      color: blueDark,
    );
  }
}

class HandDivider extends StatelessWidget {
  const HandDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        const Expanded(child: BlueLine()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/hand.png',
            height: 25,
          ),
        ),
        const Expanded(child: BlueLine()),
        const SizedBox(width: 15),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText(this.title, this.subtitle, {Key? key}) : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black54,
                Colors.transparent,
                Colors.transparent,
              ]).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Center(child: Image.asset('assets/bg.png')));
  }
}

class GradientCircle extends StatelessWidget {
  const GradientCircle({Key? key, required this.size}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 60,
      top: -60,
      child: Container(
        width: size + 300,
        height: size + 300,
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
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black38,
      child: Center(
          child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const CircularProgressIndicator(
          color: blueDark,
        ),
      )),
    );
  }
}

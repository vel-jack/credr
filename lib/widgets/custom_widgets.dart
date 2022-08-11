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
        width: image == null ? 180 : 150,
        height: image == null ? 40 : 35,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
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
      color: Colors.grey.shade400,
      height: 0.5,
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
  }) : super(key: key);
  final TextEditingController? controller;
  final RoundedCorner? corner;
  final String hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
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
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
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
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GreyText(
              text,
              fontSize: 17,
            ),
            GreyLine(
              width: lineWidth,
            ),
          ],
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

class GreyLine extends StatelessWidget {
  const GreyLine({
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
        const Expanded(child: GreyLine()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/hand.png',
            height: 25,
          ),
        ),
        const Expanded(child: GreyLine()),
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

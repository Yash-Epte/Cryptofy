import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.onPressed,
    required this.textColor,
    this.width = 100,
    this.fontSize = 14,
    this.height = 40,
    this.borderRadius = 16,
  });
  final String text;
  final double fontSize;
  final Color bgColor, textColor;
  final Function onPressed;
  final double width, height;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: bgColor,
            elevation: 3,
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize),
          )),
    );
  }
}

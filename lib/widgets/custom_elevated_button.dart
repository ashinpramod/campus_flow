import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color backgroundColor;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.backgroundColor = Colors.blueAccent,
    this.fontSize = 16.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stack_buffer_test_task/core/colors.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textStyle,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed:  onPressed,
        child:  Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(color: whiteColor),
              ),
      ),
    );
  }
}

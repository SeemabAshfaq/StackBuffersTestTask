import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stack_buffer_test_task/core/colors.dart';

class SnackbarService {
  static void showSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? title,
    IconData? icon,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      backgroundColor: mainGreenColor,
      colorText: whiteColor,
      duration: duration,
      icon: icon != null ? Icon(icon, color: whiteColor) : null,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }
}

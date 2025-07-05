import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_buffer_test_task/core/colors.dart';

class CustomSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const CustomSearchField({super.key, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: TextField(
        cursorColor: mainGreenColor,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: mainGreenColor),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w800,
            fontSize: 12.sp,
            color: mainGreenColor,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: mainGreenColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: mainGreenColor, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: mainGreenColor, width: 2),
          ),
        ),
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w800,
          color: mainGreenColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

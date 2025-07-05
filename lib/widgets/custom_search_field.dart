import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_buffer_test_task/core/colors.dart';


class CustomSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const CustomSearchField({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color:  lightBlackColor2,
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color:  lightBlackColor2,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color:  lightBlackColor2,
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

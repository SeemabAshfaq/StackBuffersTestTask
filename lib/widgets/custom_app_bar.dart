import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_buffer_test_task/core/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showBackIcon;
  const CustomAppBar({super.key, required this.title, this.showBackIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: whiteColor,
      shadowColor: whiteColor,
      foregroundColor: whiteColor,
      surfaceTintColor: whiteColor,
      clipBehavior: Clip.none,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.playfairDisplay(
          fontSize: 24.sp,
          fontWeight: FontWeight.w800,
          color: mainGreenColor,
        ),
      ),
      leading: showBackIcon == true
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/backIcon.svg",
                    colorFilter: ColorFilter.mode(
                      mainGreenColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

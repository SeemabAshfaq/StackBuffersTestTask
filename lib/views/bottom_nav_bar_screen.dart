import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/viewmodels/bottom_nav_bar_viewmodel.dart';
import 'package:stack_buffer_test_task/views/favourite_screen.dart';
import 'package:stack_buffer_test_task/views/product_list_screen.dart';
import 'package:stack_buffer_test_task/views/setting_screen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final List<Widget Function()> _pageBuilders = [
    () => const ProductListPage(),
    () => const FavouritesView(),
    () => const SettingScreen(),
  ];

  final List<String> _labels = ["Products", "Favourites", "Settings"];
  final List<String> _icons = [
    "assets/icons/products.svg",
    "assets/icons/fav.svg",
    "assets/icons/settings.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, controller, _) {
        return Scaffold(
          body: _pageBuilders[controller.currentIndex](),
          bottomNavigationBar: BottomAppBar(
            height: 75.h,
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 75.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 10, 92, 70),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _icons.length,
                  (index) => buildNavItem(
                    context,
                    controller,
                    index,
                    _icons[index],
                    _labels[index],
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        );
      },
    );
  }

  Widget buildNavItem(
    BuildContext context,
    BottomNavProvider controller,
    int index,
    String iconPath,
    String label,
  ) {
    final isSelected = controller.currentIndex == index;

    return GestureDetector(
      onTap: () {
        controller.updateIndex(index);
      },
      child: Container(
        height: 75.h,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? Radius.circular(15.r) : Radius.zero,
            topRight: index == 3 ? Radius.circular(15.r) : Radius.zero,
          ),
          color: isSelected
              ? lightBlackColor.withAlpha(13)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 21.w,
              height: 21.h,
              colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

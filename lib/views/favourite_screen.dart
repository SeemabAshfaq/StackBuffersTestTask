import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/viewmodels/favourite_viewmodel.dart';
import 'package:stack_buffer_test_task/widgets/custom_app_bar.dart';
import 'package:stack_buffer_test_task/widgets/custom_search_field.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouriteViewmodel>(context, listen: false);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: "Favourites"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            CustomSearchField(
              onChanged: (value) => favProvider.searchQuery = value,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Consumer<FavouriteViewmodel>(
                builder: (context, provider, _) => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${provider.filteredList.length} results found",
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: lightBlackColor2.withAlpha(64),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Consumer<FavouriteViewmodel>(
                builder: (context, provider, _) {
                  if (provider.filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: mainGreenColor.withValues(alpha: 0.5),
                            size: 64.h,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No favourites found',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: mainGreenColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.filteredList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var product = provider.filteredList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == provider.filteredList.length - 1
                              ? 30.h
                              : 25.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.withValues(alpha: 0.08)
                                : whiteColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5.r),
                              bottomRight: Radius.circular(5.r),
                            ),
                            border: Border(
                              left: BorderSide(
                                color: lightBlackColor2.withAlpha(13),
                                width: 1,
                              ),
                              right: BorderSide(
                                color: lightBlackColor2.withAlpha(13),
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: lightBlackColor2.withAlpha(13),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.h),
                            child: Row(
                              children: [
                                // Image
                                CircleAvatar(
                                  radius: 31.r,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: product.imageUrl.isNotEmpty
                                        ? Image.network(
                                            product.imageUrl,
                                            width: 62.w,
                                            height: 62.w,
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 14.w),

                                // Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                          color: isDarkMode
                                              ? whiteColor
                                              : lightBlackColor2,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${product.price.toString()}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w800,
                                          color: isDarkMode
                                              ? whiteColor
                                              : lightBlackColor2,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                ),

                                // Favorite Icon
                                GestureDetector(
                                  onTap: () {
                                    provider.toggleFavorite(product);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.grey.withValues(alpha: 0.5)
                                          : whiteColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.h),
                                      child: SvgPicture.asset(
                                        provider.isFavorite(product)
                                            ? "assets/icons/heart.svg"
                                            : "assets/icons/fav2.svg",
                                        width: 16.w,
                                        height: 16.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

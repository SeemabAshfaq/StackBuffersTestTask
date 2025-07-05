import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/viewmodels/product_viewmodel.dart';
import 'package:stack_buffer_test_task/widgets/custom_app_bar.dart';
import 'package:stack_buffer_test_task/widgets/custom_search_field.dart';
import 'package:stack_buffer_test_task/widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: "Products"),
      body: Consumer<ProductViewModel>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return productScreenShimmer();
          }
          // Always show search bar, even if no products found
          final showNoProducts = provider.filteredList.isEmpty;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: RefreshIndicator(
              onRefresh: () async {
                await provider.loadProducts();
              },
              child: ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomSearchField(
                    onChanged: (value) => provider.setSearchQuery(value),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${provider.filteredList.length} results found",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: lightBlackColor2.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (showNoProducts)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/products.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                            height: 40.h,
                            width: 40.w,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No Products found',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(
                      provider.visibleCount < provider.filteredList.length
                          ? provider.visibleCount
                          : provider.filteredList.length,
                      (index) {
                        final product = provider.filteredList[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == provider.filteredList.length - 1
                                ? 40.h
                                : 20,
                          ),
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              provider.fetchProductDetails(context, product.id);
                            },
                            child: ProductCard(product: product),
                          ),
                        );
                      },
                    ),
                  if (!showNoProducts &&
                      provider.visibleCount < provider.filteredList.length)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: CircularProgressIndicator(color: mainGreenColor),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productScreenShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              margin: EdgeInsets.only(top: 20.h),
            ),
          ),
          SizedBox(height: 12.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(height: 10.h, width: 100.w, color: Colors.white),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: index == 5 ? 40.h : 20.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        children: [
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 100.w,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 10.h,
                                  width: 60.w,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 14.h,
                                  width: 80.w,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:stack_buffer_test_task/viewmodels/favourite_viewmodel.dart';
import 'package:stack_buffer_test_task/widgets/custom_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouriteViewmodel>(context);
          bool isDarkMode=Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: "Product Details", showBackIcon: true),
      body: product == null
          ? Center(
              child: Text(
                'No product found',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: SizedBox(
                      // height: 209.h,
                      width: double.infinity,
                      child: Image.network(
                        product!.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return shimmerContainer(height: 209.h);
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            errorImageContainer(height: 209.h),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Details",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color:isDarkMode ? whiteColor : blackColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                favProvider.toggleFavorite(product!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:isDarkMode? Colors.grey.withValues(alpha:0.05) : whiteColor,
borderRadius: BorderRadius.circular(5.r)
                                ),
                                child: Padding(
                                 padding:  EdgeInsets.all(5.h),
                                  child: SvgPicture.asset(
                                    favProvider.isFavorite(product!)
                                        ? "assets/icons/heart.svg"
                                        : "assets/icons/fav2.svg",
                                    width: 27.w,
                                    height: 22.h,
                                    
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        productDetailRow("Name:   ", product!.title,context),
                        productDetailRow("Price:   ", "\$${product!.price}",context),

                        SizedBox(height: 8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description :", style: labelStyle(context)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Text(
                                product!.description,
                                style: valueStyle(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget productDetailRow(String label, String value,BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Text(label, style: labelStyle(context)),
          Expanded(child: Text(value, style: valueStyle(context))),
        ],
      ),
    );
  }

  TextStyle labelStyle(BuildContext context) => GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w800,
    color: Theme.of(context).brightness == Brightness.dark ? whiteColor : blackColor,
  );

  TextStyle valueStyle(BuildContext context) => GoogleFonts.poppins(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).brightness == Brightness.dark ? whiteColor : blackColor,
  );

  Widget shimmerContainer({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: double.infinity,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget errorImageContainer({required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey.shade200,
      child: Icon(Icons.broken_image, size: 30.sp, color: Colors.grey),
    );
  }
}

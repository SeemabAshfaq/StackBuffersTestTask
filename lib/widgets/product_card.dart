import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:stack_buffer_test_task/viewmodels/favourite_viewmodel.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
        final favProvider = Provider.of<FavoriteProvider>(context);
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5.r),
          bottomRight: Radius.circular(5.r),
        ),
        side: BorderSide(
          color: lightBlackColor2.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Stack(
              children: [
                Image.network(
  product.imageUrl,
  height: 172.77.h,
  width: double.infinity,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
      child: Container(
        height: 172.77.h,
        width: double.infinity,
        color: Colors.grey.shade200,
        //child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: double.infinity,
      height: 172.77.h,
      color: Colors.grey.shade200,
      child: Icon(Icons.broken_image, size: 30.sp, color: Colors.grey),
    );
  },
),
            Positioned(
              right:1 ,
              child:  Padding(
                padding:  EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                                onTap: () {
                                  favProvider.toggleFavorite(product);
                                },
                                child: SvgPicture.asset(
                                  favProvider.isFavorite(product!)
                                      ? "assets/icons/heart.svg"
                                      : "assets/icons/fav2.svg",
                                  width: 27.w,
                                  height: 22.h,
                                ),
                              ),
              ),)
            
              ],
            )

          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        maxLines: null,
                        product.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: lightBlackColor2,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Text(
                      "\$${product.price}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.sp,
                        color: lightBlackColor2,
                      ),
                    ),
                  ],
                ),

             ],
            ),
          ),
        ],
      ),
    );
  }
}

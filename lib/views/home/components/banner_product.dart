import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/config.dart';

class BannerProduct extends StatelessWidget {
  final String nameBanner;
  final String assetImage;
  final void Function() onTap;
  final Color color;

  const BannerProduct(
      {super.key,
      required this.nameBanner,
      required this.assetImage,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: 150.h,
        width: 310.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h, bottom: 10.h),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Column(
                    children: [
                      Text(
                        nameBanner,
                        style: AppFont.heading2.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            "Shop now",
                            style: AppFont.paragraphMedium
                                .copyWith(color: Colors.white54),
                          ),
                          SizedBox(width: 16.w),
                          InkWell(
                            onTap: onTap,
                            child: Icon(Icons.arrow_forward,
                                color: Colors.white, size: 20.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(assetImage,
                    fit: BoxFit.fill, width: 150.w, height: 150.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

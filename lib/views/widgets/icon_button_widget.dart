import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/config.dart';

class IconButtonWidget extends StatelessWidget {
  final String iconAsset;
  final double width;
  final double height;
  final Function onpressed;
  final double radius;
  final double widthIcon;
  final double heightIcon;

  const IconButtonWidget(
      {super.key,
      required this.iconAsset,
      required this.height,
      required this.width,
      required this.onpressed,
      required this.radius,
      required this.heightIcon,
      required this.widthIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        onPressed: () {
          onpressed();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.thirdColor, AppColor.secondColor],
            ),
          ),
          child: Container(
            width: width.w,
            height: height.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: SvgPicture.asset(
              iconAsset,
              width: heightIcon.w,
              height: widthIcon.h,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

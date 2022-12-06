import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;
  final Function onpressed;
  final double radius;
  final double fontSize;

  const ButtonWidget(
      {super.key,
      required this.buttonText,
      required this.height,
      required this.width,
      required this.onpressed,
      required this.radius,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Text(
              buttonText,
              style: AppFont.buttonMedium
                  .copyWith(color: Colors.white, fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }
}

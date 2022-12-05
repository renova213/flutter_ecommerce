import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/theme.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class SuccessCheckoutScreen extends StatelessWidget {
  const SuccessCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 75.w,
                height: 75.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColor.thirdColor, AppColor.secondColor]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 35.sp),
              ),
              SizedBox(height: 36.h),
              Text(
                "Payment Successful!",
                style: AppFont.heading1.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 45.h),
              ButtonWidget(
                  buttonText: "BACK TO HOME",
                  height: 45,
                  width: width,
                  onpressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        NavigatorFadeTransitionHelper(child: const BotNavBar()),
                        (route) => false);
                  },
                  radius: 10,
                  fontSize: 16)
            ],
          ),
        ),
      ),
    );
  }
}

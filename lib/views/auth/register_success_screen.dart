import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'login_screen.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _header(width),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        SizedBox(height: 200.h),
                        _alert(width, context),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ButtonWidget(
                    buttonText: "Continue",
                    height: 45.h,
                    width: width,
                    fontSize: 14,
                    onpressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          NavigatorFadeTransitionHelper(
                            child: const LoginScreen(),
                          ),
                          (route) => false);
                    },
                    radius: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(double width) {
    return Container(
      height: 350.h,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.mainColor, AppColor.thirdColor],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          Text(
            'Thank You!',
            style: AppFont.display3.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _alert(double width, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250.h,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(20.sp),
        ),
        border: Border.all(color: Colors.grey.shade400),
      ),
      width: width,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset('assets/images/complete.png',
                  width: 95.w, height: 95.w),
              SizedBox(height: 8.h),
              Text("Registration Completed", style: AppFont.paragraphLarge)
            ],
          ),
        ),
      ),
    );
  }
}

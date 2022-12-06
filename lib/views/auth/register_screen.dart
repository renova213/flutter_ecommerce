import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../view_models/register_view_model.dart';
import '../widgets/widgets.dart';
import 'register_success_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _header(width),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    SizedBox(height: 180.h),
                    _form(width, context),
                    SizedBox(height: 32.w)
                  ],
                ),
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
            'Register',
            style: AppFont.display3.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _form(double width, BuildContext context) {
    return Container(
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
              _formRegister(width),
              SizedBox(height: 16.h),
              Consumer<RegisterViewModel>(
                builder: (context, register, _) => ButtonWidget(
                    buttonText: "Register",
                    height: 45.h,
                    width: width,
                    fontSize: 14,
                    onpressed: () async {
                      if (register.passwordController.text !=
                          register.passwordConfirmationController.text) {
                        return Fluttertoast.showToast(
                            msg: 'Password tidak sama');
                      }

                      if (register.usernameController.text.length < 6) {
                        return Fluttertoast.showToast(
                            msg: 'Username min 8 karakter');
                      }

                      if (register.passwordController.text.length < 8) {
                        return Fluttertoast.showToast(
                            msg: 'Password min 8 karakter');
                      }

                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(register.emailController.text)) {
                        return "Use valid email";
                      }
                      try {
                        await register.postRegister().then(
                              (_) => Navigator.of(context).push(
                                NavigatorFadeTransitionHelper(
                                  child: const RegisterSuccessScreen(),
                                ),
                              ),
                            );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: e.toString(),
                        );
                      }
                    },
                    radius: 5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppFont.paragraphMedium
                          .copyWith(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: AppFont.paragraphMedium
                            .copyWith(color: AppColor.mainColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formRegister(double width) {
    return Consumer<RegisterViewModel>(
      builder: (context, register, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text("Username", style: AppFont.paragraphMedium),
          SizedBox(height: 12.h),
          //username field
          SizedBox(
            height: 45.h,
            width: width,
            child: TextField(
              controller: register.usernameController,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(32),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9 ]"),
                ),
              ],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 5, right: 8),
                hintStyle: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade400),
                hintText: "Username",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text("Email", style: AppFont.paragraphMedium),
          SizedBox(height: 12.h),
          //email field
          SizedBox(
            height: 45.h,
            width: width,
            child: TextField(
              controller: register.emailController,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9@. ]"),
                ),
              ],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 5, right: 8),
                hintStyle: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade400),
                hintText: "Enter the email",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text("Phone Number", style: AppFont.paragraphMedium),
          SizedBox(height: 12.h),
          //phone number field
          SizedBox(
            height: 45.h,
            width: width,
            child: TextField(
              controller: register.phoneController,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(14),
                FilteringTextInputFormatter.allow(
                  RegExp("[0-9]"),
                ),
              ],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 5, right: 8),
                hintStyle: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade400),
                hintText: "Enter the phone number",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text("Password", style: AppFont.paragraphMedium),
          SizedBox(height: 12.h),
          //password field
          SizedBox(
            height: 45.h,
            width: width,
            child: TextField(
              controller: register.passwordController,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9 ]"),
                ),
              ],
              obscureText: register.obscureText,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    register.changeVisibleText(!register.obscureText);
                  },
                  child: register.obscureText
                      ? const Icon(Icons.visibility_off, color: Colors.grey)
                      : const Icon(Icons.visibility, color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 5, right: 8),
                hintStyle: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade400),
                hintText: "Enter the Password",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text("Confirm Passowrd", style: AppFont.paragraphMedium),
          SizedBox(height: 12.h),
          //confirm password field
          SizedBox(
            height: 45.h,
            width: width,
            child: TextField(
              controller: register.passwordConfirmationController,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9 ]"),
                ),
              ],
              obscureText: register.obscureText2,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    register.changeVisibleText2(!register.obscureText2);
                  },
                  child: register.obscureText2
                      ? const Icon(Icons.visibility_off, color: Colors.grey)
                      : const Icon(Icons.visibility, color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 5, right: 8),
                hintStyle: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade400),
                hintText: "Enter the password",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.grey[50],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

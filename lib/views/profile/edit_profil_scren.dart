import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../view_models/user_view_model.dart';
import '../widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).initialValueController();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.thirdColor, AppColor.secondColor],
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 120.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset('assets/icons/arrow_back.svg',
                              color: Colors.white, width: 30.w, height: 30.h),
                        ),
                        Text(
                          "Profil Saya",
                          style: AppFont.heading2.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Consumer<UserViewModel>(
                      builder: (context, user, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32.h,
                          ),
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/account.svg',
                              width: 72.w,
                              height: 72.h,
                              color: AppColor.secondColor,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _disableTextField(Icons.person, user.user.name),
                          SizedBox(height: 8.h),
                          _disableTextField(Icons.email, user.user.email),
                          SizedBox(height: 8.h),
                          _disableTextField(Icons.phone, user.user.phone),
                          SizedBox(height: 8.h),
                          _textField(Icons.location_on, user.user.alamat ?? ""),
                          SizedBox(height: 32.h),
                          ButtonWidget(
                              buttonText: "Confirm",
                              height: 45,
                              width: width,
                              onpressed: () {
                                if (user.addressController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Form tidak boleh kosong");
                                } else {
                                  user.saveAddress();
                                  Fluttertoast.showToast(
                                      msg: "Berhasil update profil");
                                  Navigator.pop(context);
                                }
                              },
                              radius: 10,
                              fontSize: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _disableTextField(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 28.sp, color: AppColor.secondColor),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextField(
              controller: TextEditingController(text: title),
              enabled: false,
              style:
                  AppFont.paragraphLarge.copyWith(color: Colors.grey.shade700),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: title,
                hintStyle: AppFont.paragraphLarge
                    .copyWith(color: Colors.grey.shade400),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColor.thirdColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey[100],
                filled: true,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 28.sp, color: AppColor.secondColor),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: Consumer<UserViewModel>(
              builder: (context, user, _) => TextField(
                controller: user.addressController,
                style: AppFont.paragraphLarge
                    .copyWith(color: Colors.grey.shade700),
                cursorColor: Colors.grey.shade700,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 8, left: 16, bottom: 8, right: 8),
                  hintText: title,
                  hintStyle: AppFont.paragraphLarge
                      .copyWith(color: Colors.grey.shade400),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.thirdColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.thirdColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

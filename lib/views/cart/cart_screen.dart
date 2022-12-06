import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../view_models/cart_view_model.dart';
import '../../view_models/transaction_view_model.dart';
import '../../view_models/user_view_model.dart';
import '../checkout/success_checkout_screen.dart';
import '../profile/edit_profil_scren.dart';
import '../search/components/search_components.dart';
import '../search/search_screen.dart';
import '../widgets/button_widget.dart';
import 'components/cart_components.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<CartViewModel>(context, listen: false).fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, size: 22.sp, color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text("My Cart", style: AppFont.paragraphLargeBold),
            ),
            SizedBox(height: 50.h),
            Consumer<CartViewModel>(
              builder: (context, cart, _) {
                if (cart.appState == AppState.loaded) {
                  return _hasDataCart();
                }
                if (cart.appState == AppState.noData) {
                  return _noDataCart(width);
                }
                return _hasDataCart();
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _hasDataCart() {
    return Column(
      children: [
        const ListCart(),
        SizedBox(height: 40.h),
        const QuantityCartProduct(),
        SizedBox(height: 16.h),
        const PriceCartProduct(),
        SizedBox(height: 30.h),
        Consumer<UserViewModel>(
          builder: (context, user, _) => Consumer<TransactionViewModel>(
            builder: (context, transaction, _) => ButtonWidget(
                buttonText: 'BUY NOW',
                height: 50,
                width: 300,
                onpressed: () async {
                  if (user.user.alamat!.isEmpty) {
                    return showDialog(
                      context: context,
                      builder: (context) => _modalDataAlert(context),
                    );
                  }
                  try {
                    await transaction
                        .postTransaction(user.user.alamat!)
                        .then((_) => Fluttertoast.showToast(
                            msg: "Berhasil checkout product"))
                        .then(
                          (_) => Navigator.of(context).pushReplacement(
                            NavigatorFadeTransitionHelper(
                              child: const SuccessCheckoutScreen(),
                            ),
                          ),
                        );
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                radius: 10,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _noDataCart(double width) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 110.h,
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        "assets/images/empty_cart_image.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Wah, keranjang belanjamu kosong",
                              style: AppFont.paragraphLargeBold),
                          SizedBox(height: 8.h),
                          Text(
                            "Yuk, isi dengan barang-barang impianmu!",
                            style: AppFont.paragraphMedium
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              ButtonWidget(
                  buttonText: "Mulai Belanja",
                  height: 35,
                  width: width,
                  onpressed: () async {
                    Navigator.of(context).pushReplacement(
                      NavigatorFadeTransitionHelper(
                        child: const SearchScreen(),
                      ),
                    );

                    Fluttertoast.showToast(msg: "Alamat kamu masih kosong");
                  },
                  radius: 10,
                  fontSize: 14),
            ],
          ),
        ),
        SizedBox(height: 32.h),
        const FeaturedProductRecommendation(),
      ],
    );
  }

  Widget _modalDataAlert(context) {
    return Center(
      child: Container(
        width: 330.w,
        height: 310.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close,
                      color: Colors.grey.shade500, size: 32.sp),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 50.h,
                width: 50.w,
                child: Image.asset('assets/images/warning.png'),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                "Duh, data dirimu masih belum lengkap!",
                style: AppFont.paragraphLargeBold,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Yuk, lengkapi data profilmu terlebih dahulu sebelum kembali melanjutkan pemesanan.",
                style: AppFont.paragraphMedium
                    .copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(
                height: 32.h,
              ),
              Center(
                child: ButtonWidget(
                    buttonText: "Lengkapi Profil",
                    height: 45,
                    width: 200,
                    onpressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        NavigatorFadeTransitionHelper(
                          child: const EditProfileScreen(),
                        ),
                      );
                    },
                    radius: 10,
                    fontSize: 16),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

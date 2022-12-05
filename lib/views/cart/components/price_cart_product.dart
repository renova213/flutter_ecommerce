import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/theme.dart';
import '../../../view_models/cart_view_model.dart';

class PriceCartProduct extends StatelessWidget {
  const PriceCartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cart, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: AppFont.paragraphMediumBold),
            Text(
              "Rp ${cart.sumPriceProducts}",
              style: AppFont.paragraphMediumBold
                  .copyWith(color: AppColor.mainColor),
            ),
          ],
        ),
      ),
    );
  }
}

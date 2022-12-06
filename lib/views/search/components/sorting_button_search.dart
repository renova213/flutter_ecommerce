import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../view_models/search_view_model.dart';
import '../../widgets/widgets.dart';

class SortingButtonSearch extends StatelessWidget {
  const SortingButtonSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ButtonWidget(
          buttonText: 'Sorting',
          height: 46.h,
          width: width,
          onpressed: () {
            _modalAction(context, width);
          },
          radius: 10,
          fontSize: 16),
    );
  }

  void _modalAction(BuildContext context, double width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.grey[50],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 72.h,
                      width: width,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Color(0xffEDEDED), width: 2),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 16.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sorting", style: AppFont.paragraphLargeBold),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close,
                                      size: 25, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Consumer<SearchProductViewModel>(
                      builder: (context, search, _) => Column(
                        children: [
                          _containerAction(
                              nameAction: 'Name (A-Z)',
                              function: () {
                                search.changeIndex(0);
                                search.ascendingSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 0),
                          _containerAction(
                              nameAction: 'Name (Z-A)',
                              function: () {
                                search.changeIndex(1);
                                search.descendingSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 1),
                          _containerAction(
                              nameAction: 'Price (Low-High)',
                              function: () {
                                search.changeIndex(2);
                                search.lowPriceSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 2),
                          _containerAction(
                              nameAction: 'Price (High-Low)',
                              function: () {
                                search.changeIndex(3);
                                search.highPriceSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _containerAction(
      {required String nameAction,
      required void Function() function,
      required double width,
      required int index}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: function,
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 16.w),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 60.h,
            width: width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffEDEDED), width: 2),
              ),
            ),
            child: Consumer<SearchProductViewModel>(
              builder: (context, search, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nameAction,
                    style: AppFont.paragraphMedium
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  search.selectedIndex == index
                      ? SvgPicture.asset('assets/icons/checklist.svg',
                          width: 30.w, height: 30.h)
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

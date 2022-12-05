import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../../view_models/search_view_model.dart';
import '../result_search_screen.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Terakhir Dicari", style: AppFont.buttonLarge),
              _deleteIndexSearch(),
            ],
          ),
          SizedBox(height: 16.h),
          _listRecentSearch(),
        ],
      ),
    );
  }

  Widget _listRecentSearch() {
    return Consumer<SearchProductViewModel>(
      builder: (context, search, _) => ListView.builder(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            search.recentSearch.length < 8 ? search.recentSearch.length : 8,
        itemBuilder: (context, index) {
          final data = search.recentSearch[index];

          return SizedBox(
            height: 35.h,
            child: InkWell(
              onTap: () {
                search.searchProductByTap(data);
                search.searchController.text = data;
                Navigator.of(context).pushReplacement(
                  NavigatorFadeTransitionHelper(
                    child: const ResultSearchScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history,
                          size: 20.sp, color: Colors.grey.shade500),
                      SizedBox(width: 8.w),
                      Text(
                        data,
                        style: AppFont.paragraphMedium
                            .copyWith(color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      search.removeRecentSearchByIndex(index);
                    },
                    child: Icon(Icons.close,
                        size: 20.sp, color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _deleteIndexSearch() {
    return Consumer<SearchProductViewModel>(
      builder: (context, search, _) => InkWell(
        onTap: () {
          search.removeRecentSearch();
        },
        child: Text(
          "Hapus Semua",
          style: AppFont.paragraphLarge.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}

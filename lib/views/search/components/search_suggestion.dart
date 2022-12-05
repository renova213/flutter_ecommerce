import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../../view_models/search_view_model.dart';
import '../result_search_screen.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<SearchProductViewModel>(
              builder: (context, search, _) =>
                  Text("Saran Pencarian", style: AppFont.buttonLarge)),
          SizedBox(height: 16.h),
          _listRecentSearch(),
        ],
      ),
    );
  }

  Widget _listRecentSearch() {
    return Consumer<SearchProductViewModel>(
      builder: (context, search, _) {
        if (search.appState == AppState.failure) {
          return Center(
            child: Text("Failed get data from server",
                style: AppFont.paragraphLargeBold),
          );
        }
        if (search.appState == AppState.noData) {
          return Center(
            child: Column(
              children: [
                Text("There Are No Suitable Product",
                    style: AppFont.paragraphLargeBold,
                    textAlign: TextAlign.center),
                SizedBox(height: 20.h),
                Text("Please try using other keywords to find the product name",
                    style: AppFont.paragraphMedium
                        .copyWith(color: Colors.grey.shade600),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        }

        if (search.appState == AppState.loaded) {
          return ListView.builder(
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                search.searchResult.length < 8 ? search.searchResult.length : 8,
            itemBuilder: (context, index) {
              final data = search.searchResult[index];
              return SizedBox(
                height: 35.h,
                child: InkWell(
                  onTap: () {
                    search.searchProductByTap(data.name);
                    search.searchController.text = data.name;
                    Navigator.of(context).pushReplacement(
                      NavigatorFadeTransitionHelper(
                        child: const ResultSearchScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.history,
                          size: 20.sp, color: Colors.grey.shade500),
                      SizedBox(width: 8.w),
                      Text(
                        data.name,
                        style: AppFont.paragraphMedium
                            .copyWith(color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

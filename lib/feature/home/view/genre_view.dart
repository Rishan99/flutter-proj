import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/core/theme/app_colors.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/genre/model/genre_model.dart';
import 'package:moviehub/feature/home/widget/genre/genre_tab_shimmer.dart';
import 'package:moviehub/feature/home/widget/genre/genre_tabs_shimmer_row.dart';
import 'package:moviehub/feature/home/widget/genre/tab_genre_widget.dart';
import 'package:moviehub/services/general/general_service.dart';
import 'package:moviehub/shared/widgets/custom_ink_well.dart';
import 'package:moviehub/shared/widgets/form_seperator_box.dart';
import 'package:moviehub/shared/widgets/load_page_widget.dart';

class GenreView extends StatelessWidget {
  const GenreView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadPageWidget<List<GenreModel>>(
        loadingWidget: GenreTabsShimmerRow(),
        futureFunction: locator<GeneralService>().getGenres(),
        builder: (context, listData) {
          final data = [GenreModel(id: -1, name: "   All   "), ...listData];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDefaults.kPageSidePadding.left,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Genre",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    CustomInkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.genreList);
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FormSeperatorBox(),
              SizedBox(
                height: 32.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDefaults.kPageSidePadding.left,
                  ),
                  separatorBuilder: (_, __) => adaptableWidth(width: 8),
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TabGenreWidget(
                      data: data[index],
                      isSelected: index == 0,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}

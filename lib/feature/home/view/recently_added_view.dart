import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/home/widget/grid_widget/grid_movie_shimmer.dart';
import 'package:moviehub/feature/home/widget/grid_widget/grid_movie_shimmer_row.dart';
import 'package:moviehub/feature/home/widget/grid_widget/grid_movie_widget.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/load_page_widget.dart';

class RecentlyAddedView extends StatelessWidget {
  const RecentlyAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadPageWidget<List<MovieModel>>(
        loadingWidget: GridMovieShimmerRow(),
        futureFunction: locator<MovieService>().getRecentlyAdded(),
        builder: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDefaults.kPageSidePadding.left,
                ),
                child: Text(
                  "Recently Added",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              FormSeperatorBox(),
              SizedBox(
                height: 230.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDefaults.kPageSidePadding.left,
                  ),
                  separatorBuilder: (_, __) => adaptableWidth(width: 12),
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GridMovieWidget(data: data[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}

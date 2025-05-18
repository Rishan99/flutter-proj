import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'grid_movie_shimmer.dart';

class GridMovieShimmerRow extends StatelessWidget {
  const GridMovieShimmerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDefaults.kPageSidePadding.left),
      child: SizedBox(
        height: 180.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) => const GridMovieShimmer(),
        ),
      ),
    );
  }
}

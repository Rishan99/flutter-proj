import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'genre_tab_shimmer.dart';

class GenreTabsShimmerRow extends StatelessWidget {
  const GenreTabsShimmerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDefaults.kPageSidePadding,
      child: SizedBox(
        height: 30.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6, // Show 6 shimmer tabs
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) => const GenreTabShimmer(),
        ),
      ),
    );
  }
}

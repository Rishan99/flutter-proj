import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/widgets/shrimmer.dart';

class FeaturedViewShimmer extends StatelessWidget {
  const FeaturedViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDefaults.kPageSidePadding,
      child: RectangularShrimmer(
        size: Size(double.maxFinite, 200.h), // Match image size
        borderRadius: 12,
      ),
    );
  }
}

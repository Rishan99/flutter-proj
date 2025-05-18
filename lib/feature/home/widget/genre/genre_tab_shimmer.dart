import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/widgets/shrimmer.dart';

class GenreTabShimmer extends StatelessWidget {
  const GenreTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangularShrimmer(
      size: Size(80.w, double.maxFinite), // Approximate size of a genre tab
      borderRadius: 20,
    );
  }
}

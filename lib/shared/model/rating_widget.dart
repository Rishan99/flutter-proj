// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/theme/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.secondary,
          size: 16.sp,
        ),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

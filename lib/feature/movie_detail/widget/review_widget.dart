// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/theme/app_colors.dart';

import 'package:moviehub/shared/model/review_model.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      contentPadding: AppDefaults.kPageSidePadding,
      // leading: const CircleAvatar(
      //   backgroundImage: NetworkImage(
      //       'https://www.example.com/path/to/profile/image.jpg'),
      // ),
      title: Text(
        review.user,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        review.review,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        "${review.rating}★",
        style: TextStyle(color: AppColors.secondary, fontSize: 14.sp),
      ),
    );
  }
}

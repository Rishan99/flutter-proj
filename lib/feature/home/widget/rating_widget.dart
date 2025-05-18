// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/shared/model/rating_widget.dart';

class RatingBoxWidget extends StatelessWidget {
  final double rating;
  const RatingBoxWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff252836).withOpacity(0.23),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: RatingWidget(rating: rating),
    );
  }
}

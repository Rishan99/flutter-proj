// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/feature/home/widget/rating_widget.dart';
import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/image_widget.dart';

class GridMovieWidget extends StatelessWidget {
  final MovieModel data;
  const GridMovieWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.movieDetail,
          arguments: {
            "id": data.id,
          },
        );
      },
      child: SizedBox(
        height: 230.h,
        width: 160.w,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ImageWidget(
                        // clipBorder: true,
                        height: double.maxFinite,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        imageUrl: data.coverImage,
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: RatingBoxWidget(
                          rating: data.averageRating,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        data.genre,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff92929D),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

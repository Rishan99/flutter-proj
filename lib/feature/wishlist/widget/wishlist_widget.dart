// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/routes/routes.dart';

import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/shared/model/rating_widget.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/image_widget.dart';
import 'package:moviehub/widgets/wishlist_icon.dart';

class WishlistWidget extends StatelessWidget {
  final MovieModel data;
  const WishlistWidget({
    super.key,
    required this.data,
  });

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
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                width: 100.w,
                height: 100.h,
                imageUrl: data.coverImage,
              ),
              adaptableWidth(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.genre,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    adaptableHeight(height: 6),
                    Text(
                      data.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    adaptableHeight(height: 6),
                    Row(
                      children: [
                        Text(
                          data.movieType,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff92929D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        adaptableWidth(width: 8),
                        RatingLabelWidget(rating: data.averageRating),
                        Expanded(child: SizedBox.shrink()),
                        WishlistIcon(
                          movieId: data.id,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

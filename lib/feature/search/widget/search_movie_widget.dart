// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/feature/movie_detail/widget/label_widget.dart';

import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/shared/widgets/form_seperator_box.dart';
import 'package:moviehub/shared/widgets/image_widget.dart';

class SearchMovieWidget extends StatelessWidget {
  final MovieModel movie;
  const SearchMovieWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(
          imageUrl: movie.coverImage,
          height: 150.h,
          width: 110.w,
        ),
        adaptableWidth(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movieReleaseOrNotChip(DateTime.parse(movie.releaseDate)),
              // FormSeperatorBox(
              //   height: 5.h,
              // ),
              Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayMedium),
              FormSeperatorBox(
                height: 8.h,
              ),
              LabelWidget(
                icon: Icons.calendar_month_sharp,
                label: DateTime.parse(movie.releaseDate).year.toString(),
              ),
              FormSeperatorBox(
                height: 4.h,
              ),
              LabelWidget(
                icon: Icons.timer,
                label: "${movie.runtime} Minutes",
              ),
              FormSeperatorBox(
                height: 4.h,
              ),
              LabelWidget(
                icon: MdiIcons.filmstrip,
                label: movie.genre,
              ),
            ],
          ),
        )
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/core/theme/app_colors.dart';
import 'package:moviehub/feature/genre/model/genre_model.dart';
import 'package:moviehub/shared/widgets/custom_ink_well.dart';

class TabGenreWidget extends StatelessWidget {
  final bool isSelected;
  final GenreModel data;
  const TabGenreWidget({
    Key? key,
    required this.isSelected,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.genreMovieList, arguments: {
          'genreId': data.id < 0 ? null : data.id,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardBackgroundColor : null,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Center(
          child: Text(
            data.name,
            style: TextStyle(
              color: isSelected ? AppColors.primary : null,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

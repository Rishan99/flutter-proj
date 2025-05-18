// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/feature/genre/model/genre_model.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/image_widget.dart';

class GenreWidget extends StatelessWidget {
  final GenreModel data;
  const GenreWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.movieList,
          arguments: {
            'genreId': data.id,
          },
        );
      },
      child: Stack(
        children: [
          ImageWidget(
            clipBorder: true,
            width: double.maxFinite,
            imageUrl: data.image,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            height: double.maxFinite,
            width: double.maxFinite,
            child: Center(
              child: Text(
                data.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

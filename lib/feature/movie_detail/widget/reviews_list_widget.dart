// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:moviehub/feature/movie_detail/widget/review_widget.dart';
import 'package:moviehub/shared/model/movie_model.dart';

class ReviewsListWidget extends StatelessWidget {
  final MovieModel movie;
  const ReviewsListWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) => ReviewWidget(review: movie.ratings[index]),
      separatorBuilder: (context, index) => Divider(),
      itemCount: movie.ratings.length,
    );
  }
}

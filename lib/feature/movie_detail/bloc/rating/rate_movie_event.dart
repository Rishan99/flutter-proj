part of 'rate_movie_bloc.dart';

abstract class RateMovieEvent {}

class SubmitRating extends RateMovieEvent {
  final double rating;
  final String description;
  SubmitRating({required this.rating, required this.description});
}

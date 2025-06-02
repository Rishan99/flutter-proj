part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {}

class FetchMovieDetail extends MovieDetailEvent {
  FetchMovieDetail();
}

class RateMovie extends MovieDetailEvent {
  final double rating;
  final String description;
  RateMovie({required this.rating, required this.description});
}

part of 'rate_movie_bloc.dart';

abstract class RateMovieState {}

class RateMovieInitial extends RateMovieState {}

class RateMovieLoading extends RateMovieState {}

class RateMovieSuccess extends RateMovieState {}

class RateMovieError extends RateMovieState {
  final String message;
  RateMovieError(this.message);
}

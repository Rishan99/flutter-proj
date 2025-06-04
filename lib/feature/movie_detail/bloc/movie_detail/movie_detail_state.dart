part of 'movie_detail_bloc.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState implements LoadingState {}

class MovieDetailLoaded extends MovieDetailState implements LoadedState {
  final MovieModel movie;
  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState implements ErrorState {
  @override
  final String message;
  MovieDetailError(this.message);
}

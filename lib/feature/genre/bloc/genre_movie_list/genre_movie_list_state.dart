part of 'genre_movie_list_bloc.dart';

abstract class GenreMovieListState {}

class GenreMovieListInitial extends GenreMovieListState {}

class GenreMovieListLoading extends GenreMovieListState implements LoadingState {}

class GenreMovieListLoaded extends GenreMovieListState implements LoadedState {
  final List<MovieModel> movies;
  GenreMovieListLoaded(this.movies);
}

class GenreMovieListError extends GenreMovieListState implements ErrorState {
  @override
  final String message;
  GenreMovieListError(this.message);
}

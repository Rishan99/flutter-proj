part of 'genre_movie_list_bloc.dart';

abstract class GenreMovieListEvent {}

class FetchGenreMovies extends GenreMovieListEvent {
  final int? genreId;
  FetchGenreMovies(this.genreId);
}

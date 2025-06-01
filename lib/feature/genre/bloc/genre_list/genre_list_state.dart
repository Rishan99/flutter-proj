part of 'genre_list_bloc.dart';

abstract class GenreListState {}

class GenreListInitial extends GenreListState {}

class GenreListLoading extends GenreListState implements LoadingState {}

class GenreListLoaded extends GenreListState implements LoadedState {
  final List<GenreModel> genres;
  GenreListLoaded(this.genres);
}

class GenreListError extends GenreListState implements ErrorState {
  @override
  final String message;
  GenreListError(this.message);
}

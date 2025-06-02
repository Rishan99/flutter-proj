part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState implements LoadingState {}

class SearchLoaded extends SearchState implements LoadedState {
  final List<MovieModel> movies;
  SearchLoaded(this.movies);
}

class SearchError extends SearchState implements ErrorState {
  @override
  final String message;
  SearchError(this.message);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';

part 'genre_movie_list_event.dart';
part 'genre_movie_list_state.dart';

class GenreMovieListBloc extends Bloc<GenreMovieListEvent, GenreMovieListState> {
  final MovieService movieService;
  final int genreId;

  GenreMovieListBloc(this.movieService, this.genreId) : super(GenreMovieListInitial()) {
    on<FetchGenreMovies>(fetchGenreMovies);
    add(FetchGenreMovies(genreId));
  }

  Future<void> fetchGenreMovies(FetchGenreMovies event, Emitter<GenreMovieListState> emit) async {
    emit(GenreMovieListLoading());
    try {
      final movies = await movieService.searchMovie("", event.genreId);
      emit(GenreMovieListLoaded(movies));
    } catch (e) {
      emit(GenreMovieListError(e.toString()));
    }
  }
}

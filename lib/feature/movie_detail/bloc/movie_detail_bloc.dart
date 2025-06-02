import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieService movieService;
  final int movieId;
  MovieDetailBloc(this.movieService, this.movieId) : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<RateMovie>(_onRateMovie);
    add(FetchMovieDetail());
  }

  Future<void> _onFetchMovieDetail(FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      final movie = await movieService.getDetailById(movieId);
      emit(MovieDetailLoaded(movie));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }

  Future<void> _onRateMovie(RateMovie event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      await movieService.rate(movieId, event.rating, event.description);
      emit(RatingAddedSuccess());
      await movieService.getDetailById(movieId).then((movie) {
        emit(MovieDetailLoaded(movie));
      });
    } catch (e) {
      emit(RatingAddedError(e.toString()));
    }
  }
}

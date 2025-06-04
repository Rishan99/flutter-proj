import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/services/movie/movie_service.dart';
part 'rate_movie_event.dart';
part 'rate_movie_state.dart';

class RateMovieBloc extends Bloc<RateMovieEvent, RateMovieState> {
  final MovieService movieService;
  final int movieId;
  RateMovieBloc(this.movieService, this.movieId) : super(RateMovieInitial()) {
    on<SubmitRating>(_onSubmitRating);
  }

  Future<void> _onSubmitRating(SubmitRating event, Emitter<RateMovieState> emit) async {
    emit(RateMovieLoading());
    try {
      await movieService.rate(movieId, event.rating, event.description);
      emit(RateMovieSuccess());
    } catch (e) {
      emit(RateMovieError(e.toString()));
    }
  }
}

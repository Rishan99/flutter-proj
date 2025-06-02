import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieService movieService;
  SearchBloc(this.movieService) : super(SearchInitial()) {
    on<PerformSearch>(_onPerformSearch);
  }

  Future<void> _onPerformSearch(PerformSearch event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final movies = await movieService.searchMovie(event.query, null);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

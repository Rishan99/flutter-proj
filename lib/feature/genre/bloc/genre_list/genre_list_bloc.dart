import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/feature/genre/model/genre_model.dart';
import 'package:moviehub/services/general/general_service.dart';

part 'genre_list_event.dart';
part 'genre_list_state.dart';

class GenreListBloc extends Bloc<GenreListEvent, GenreListState> {
  final GeneralService generalService;
  GenreListBloc(this.generalService) : super(GenreListInitial()) {
    on<FetchGenres>(fetchGenres);
    add(FetchGenres());
  }

  Future<void> fetchGenres(FetchGenres event, Emitter<GenreListState> emit) async {
    emit(GenreListLoading());
    try {
      final genres = await generalService.getGenres();
      emit(GenreListLoaded(genres));
    } catch (e) {
      emit(GenreListError(e.toString()));
    }
  }
}

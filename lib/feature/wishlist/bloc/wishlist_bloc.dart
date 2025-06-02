import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/services/user/user_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final UserService userService;
  WishlistBloc(this.userService) : super(WishlistInitial()) {
    on<FetchWishlist>(_onFetchWishlist);
    add(FetchWishlist());
  }

  Future<void> _onFetchWishlist(FetchWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      final movies = await userService.getFavouriteMovies();
      emit(WishlistLoaded(movies));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}

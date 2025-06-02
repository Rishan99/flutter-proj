part of 'wishlist_bloc.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState implements LoadingState {}

class WishlistLoaded extends WishlistState implements LoadedState {
  final List<MovieModel> movies;
  WishlistLoaded(this.movies);
}

class WishlistError extends WishlistState implements ErrorState {
  @override
  final String message;
  WishlistError(this.message);
}

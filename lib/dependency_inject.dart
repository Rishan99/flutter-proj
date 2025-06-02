import 'package:moviehub/services/auth/auth_service.dart';
import 'package:moviehub/services/core/http_service.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:get_it/get_it.dart';
import 'package:moviehub/services/general/general_service.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/services/user/user_service.dart';
import 'package:moviehub/feature/genre/bloc/genre_list/genre_list_bloc.dart';
import 'package:moviehub/feature/genre/bloc/genre_movie_list/genre_movie_list_bloc.dart';
import 'package:moviehub/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:moviehub/feature/search/bloc/search_bloc.dart';
import 'package:moviehub/feature/wishlist/bloc/wishlist_bloc.dart';
import 'package:moviehub/feature/auth/bloc/signup/signup_bloc.dart';
import 'package:moviehub/feature/auth/bloc/login/login_bloc.dart';

final locator = GetIt.instance;

setupDependencies() async {
  ///[Core]
  locator.registerSingletonAsync<PreferenceService>(
    () => PreferenceService.getInstance(),
  );

  final preferenceService = await locator.getAsync<PreferenceService>();
  locator.registerSingleton<HttpService>(
    HttpService(preferenceService),
  );
  final httpService = locator<HttpService>();

  // // ///[Services]
  locator.registerSingleton<AuthService>(AuthService(httpService));
  locator.registerSingleton<UserService>(UserService(httpService));
  locator.registerSingleton<GeneralService>(GeneralService(httpService));
  locator.registerSingleton<MovieService>(MovieService(httpService));

  // Register GenreListBloc with injected GeneralService
  locator.registerFactory<GenreListBloc>(
    () => GenreListBloc(locator<GeneralService>()),
  );

  // Register GenreMovieListBloc with injected MovieService and param1 for genreId
  locator.registerFactoryParam<GenreMovieListBloc, int, void>(
    (genreId, _) => GenreMovieListBloc(locator<MovieService>(), genreId),
  );

  // Register MovieDetailBloc with injected MovieService and param1 for movieId
  locator.registerFactoryParam<MovieDetailBloc, int, void>(
    (movieId, _) => MovieDetailBloc(locator<MovieService>(), movieId),
  );

  // Register SearchBloc with injected MovieService
  locator.registerFactory<SearchBloc>(
    () => SearchBloc(locator<MovieService>()),
  );

  // Register WishlistBloc with injected UserService
  locator.registerFactory<WishlistBloc>(
    () => WishlistBloc(locator<UserService>()),
  );

  // Register SignupBloc with injected AuthService
  locator.registerFactory<SignupBloc>(
    () => SignupBloc(locator<AuthService>()),
  );

  // Register LoginBloc with injected AuthService
  locator.registerFactory<LoginBloc>(
    () => LoginBloc(locator<AuthService>()),
  );
}

import 'package:moviehub/services/auth/auth_service.dart';
import 'package:moviehub/services/core/http_service.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:get_it/get_it.dart';
import 'package:moviehub/services/general/general_service.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/services/user/user_service.dart';
import 'package:moviehub/feature/genre/bloc/genre_list/genre_list_bloc.dart';
import 'package:moviehub/feature/genre/bloc/genre_movie_list/genre_movie_list_bloc.dart';
import 'package:moviehub/feature/movie_detail/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:moviehub/feature/movie_detail/bloc/rate_movie_bloc.dart';
import 'package:moviehub/feature/search/bloc/search_bloc.dart';
import 'package:moviehub/feature/wishlist/bloc/wishlist_bloc.dart';
import 'package:moviehub/feature/auth/bloc/signup/signup_bloc.dart';
import 'package:moviehub/feature/auth/bloc/login/login_bloc.dart';
import 'package:moviehub/feature/splash/bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

setupDependencies() async {
  await _initService();
  _initBloc();
}

_initService() async {
  ///[Core]
  var prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<PreferenceService>(
    PreferenceService(prefs),
  );

  final preferenceService = locator.get<PreferenceService>();
  locator.registerSingleton<HttpService>(
    HttpService(preferenceService),
  );
  final httpService = locator<HttpService>();

  ///[Services]
  locator.registerSingleton<AuthService>(AuthService(httpService));
  locator.registerSingleton<UserService>(UserService(httpService));
  locator.registerSingleton<GeneralService>(GeneralService(httpService));
  locator.registerSingleton<MovieService>(MovieService(httpService));
}

_initBloc() {
  locator.registerFactory<GenreListBloc>(
    () => GenreListBloc(locator<GeneralService>()),
  );

  locator.registerFactoryParam<GenreMovieListBloc, int, void>(
    (genreId, _) => GenreMovieListBloc(locator<MovieService>(), genreId),
  );

  locator.registerFactoryParam<MovieDetailBloc, int, void>(
    (movieId, _) => MovieDetailBloc(locator<MovieService>(), movieId),
  );

  locator.registerFactoryParam<RateMovieBloc, int, void>(
    (movieId, _) => RateMovieBloc(locator<MovieService>(), movieId),
  );

  locator.registerFactory<SearchBloc>(
    () => SearchBloc(locator<MovieService>()),
  );

  locator.registerFactory<WishlistBloc>(
    () => WishlistBloc(locator<UserService>()),
  );
  locator.registerFactory<SignupBloc>(
    () => SignupBloc(locator<AuthService>()),
  );

  locator.registerFactory<LoginBloc>(
    () => LoginBloc(locator<AuthService>(), locator<PreferenceService>()),
  );
  locator.registerFactory<SplashBloc>(
    () => SplashBloc(locator<PreferenceService>()),
  );
}

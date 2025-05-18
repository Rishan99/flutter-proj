import 'package:moviehub/services/auth/auth_service.dart';
import 'package:moviehub/services/core/http_service.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:get_it/get_it.dart';
import 'package:moviehub/services/general/general_service.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/services/user/user_service.dart';

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
  // locator.registerSingleton<LocalNotificationService>(LocalNotificationService(locator<NotificationHandler>()));
  // locator.registerSingleton<FirebaseNotificationService>(FirebaseNotificationService(locator<NotificationHandler>()));
  // locator.registerSingleton<AuthService>(AuthService(httpService));
  // locator.registerSingleton<FirebaseAuthService>(FirebaseAuthService(preferenceService));
  // locator.registerSingleton<BusinessService>(BusinessService(httpService));
  // locator.registerSingleton<CouponService>(CouponService(httpService));
  // locator.registerSingleton<DealService>(DealService(httpService));
  // locator.registerSingleton<EventService>(EventService(httpService));
  // locator.registerSingleton<GeneralService>(GeneralService(httpService));
  // locator.registerSingleton<JobService>(JobService(httpService));
  // locator.registerSingleton<MenuService>(MenuService(httpService));
  // locator.registerSingleton<NewArrivalService>(NewArrivalService(httpService));
  // locator.registerSingleton<NotificationService>(NotificationService(httpService));
  // locator.registerSingleton<PointService>(PointService(httpService));
  // locator.registerSingleton<UserService>(UserService(httpService));
  // locator.registerSingleton<RateService>(RateService(httpService));
  // locator.registerSingleton<GalleryService>(GalleryService(httpService));
  // locator.registerSingleton<StampService>(StampService(httpService));
  // locator.registerSingleton<ChatService>(ChatService(httpService));
  // locator.registerSingleton<CardService>(CardService(httpService));
}

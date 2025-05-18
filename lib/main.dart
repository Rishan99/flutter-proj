import 'dart:io';

import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/routes/route_manager.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../core/routes/routes.dart';
import '../core/theme/themes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => ToastificationWrapper(
              child: MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splashPage,
                themeMode: ThemeMode.dark,
                title: AppDefaults.appName,
                theme: Themes().theme(),
                onGenerateRoute: onGenerateRoute,
              ),
            ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}

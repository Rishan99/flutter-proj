import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/constant/image_const.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/core/theme/app_colors.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    processNavigation();
  }

  processNavigation() async {
    await Future.delayed(Duration(seconds: 2));
    final prefs = locator<PreferenceService>();
    late final String toPage;
    if (prefs.accessToken.isEmpty) {
      toPage = Routes.loginPage;
    } else {
      toPage = Routes.homePage;
    }
    Navigator.of(context).pushReplacementNamed(toPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConst.appLogo,
            ),
            FormSeperatorBox(),
            Text(
              AppDefaults.appName,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

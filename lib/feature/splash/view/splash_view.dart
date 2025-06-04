import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/constant/image_const.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/core/theme/app_colors.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/shared/widgets/form_seperator_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/feature/splash/bloc/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SplashBloc>(),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLogin) {
            Navigator.of(context).pushReplacementNamed(Routes.loginPage);
          } else if (state is SplashNavigateToHome) {
            Navigator.of(context).pushReplacementNamed(Routes.homePage);
          }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}

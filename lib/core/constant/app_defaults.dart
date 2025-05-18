import 'package:moviehub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDefaults {
  static String appName = "MovieHUB";
  static EdgeInsets kPageSidePadding = EdgeInsets.symmetric(horizontal: 16.w);
  static TextStyle headerTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 48.sp, color: AppColors.secondary, height: 1.1);
  static double get buttonHeight => 46.h;
  static const String fontFamily = "Aeonik";
  static double get borderRadius => 8.sp;
}

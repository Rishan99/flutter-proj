// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/theme/app_colors.dart';

class BottomBar extends StatelessWidget {
  final int index;
  final Function(int index) onTabChange;
  const BottomBar({
    Key? key,
    required this.index,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GNav(
        gap: 8,
        selectedIndex: index,
        onTabChange: onTabChange,
        color: Color(0xff92929D),
        activeColor: AppColors.primary,
        iconSize: 24,
        tabBackgroundColor: AppColors.kColorBackground,
        padding: EdgeInsets.symmetric(horizontal: AppDefaults.kPageSidePadding.left.h, vertical: 12.h),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Wishlist',
          ),
          GButton(
            icon: Icons.account_circle_rounded,
            text: 'Profile',
          )
        ]);
  }
}

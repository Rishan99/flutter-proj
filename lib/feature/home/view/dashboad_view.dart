import 'package:flutter/material.dart';

import 'package:moviehub/feature/home/view/home_view.dart';
import 'package:moviehub/feature/home/widget/bottom_bar.dart';
import 'package:moviehub/feature/search/view/search_view.dart';
import 'package:moviehub/feature/wishlist/view/wishlist_view.dart';

class DashboadView extends StatefulWidget {
  const DashboadView({super.key});

  @override
  State<DashboadView> createState() => _DashboadViewState();
}

class _DashboadViewState extends State<DashboadView> with SingleTickerProviderStateMixin {
  late final TabController _tabBarController;
  ValueNotifier<int> _tabBarIndex = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: 4, vsync: this);
    _tabBarController.addListener(() {
      _tabBarIndex.value = _tabBarController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: _tabBarIndex,
            builder: (context, _, __) {
              return BottomBar(
                  index: _tabBarIndex.value,
                  onTabChange: (index) {
                    _tabBarController.animateTo(index);
                  });
            }),
        body: TabBarView(
          controller: _tabBarController,
          children: [
            HomeView(),
            SearchView(),
            WishlistView(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

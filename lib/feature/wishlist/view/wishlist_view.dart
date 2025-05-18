import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/wishlist/widget/wishlist_widget.dart';
import 'package:moviehub/services/user/user_service.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/load_page_widget.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
        ),
        body: LoadPageWidget(
          noDataWidget: CenterHintText(text: "There is no movie in your wishlist"),
          futureFunction: locator<UserService>().getFavouriteMovies(),
          builder: (context, data) => ListView.separated(
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (context, index) => WishlistWidget(data: data[index]),
            separatorBuilder: (context, index) => FormSeperatorBox(),
            itemCount: data.length,
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

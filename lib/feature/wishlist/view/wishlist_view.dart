import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/wishlist/bloc/wishlist_bloc.dart';
import 'package:moviehub/core/bloc/view/bloc_builder_view.dart';
import 'package:moviehub/feature/wishlist/widget/wishlist_widget.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';

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
        body: BlocProvider(
          create: (_) => locator<WishlistBloc>(),
          child: BlocBuilderView<WishlistBloc, WishlistState, WishlistLoaded>(
            child: (context, state) {
              if (state.movies.isEmpty) {
                return CenterHintText(text: "There is no movie in your wishlist");
              }
              return ListView.separated(
                padding: EdgeInsets.only(bottom: 16.h),
                itemBuilder: (context, index) => WishlistWidget(data: state.movies[index]),
                separatorBuilder: (context, index) => FormSeperatorBox(),
                itemCount: state.movies.length,
              );
            },
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

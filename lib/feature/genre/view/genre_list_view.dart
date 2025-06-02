import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/view/bloc_builder_view.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/genre/widget/genre_widget.dart';
import 'package:moviehub/feature/genre/bloc/genre_list/genre_list_bloc.dart';
import 'package:moviehub/widgets/center_hint_text.dart';

class GenreListView extends StatefulWidget {
  const GenreListView({super.key});

  @override
  State<GenreListView> createState() => _GenreListViewState();
}

class _GenreListViewState extends State<GenreListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genre"),
      ),
      body: Padding(
        padding: AppDefaults.kPageSidePadding,
        child: BlocProvider.value(
          value: locator<GenreListBloc>(),
          child: BlocBuilderView<GenreListBloc, GenreListState, GenreListLoaded>(
            child: (context, state) {
              if (state.genres.isEmpty) {
                return const CenterHintText(text: "No genres found");
              }
              return GridView.builder(
                itemCount: state.genres.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18.sp,
                  crossAxisSpacing: 18.sp,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) => GenreWidget(
                  data: state.genres[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

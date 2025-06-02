// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/view/bloc_builder_view.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/genre/bloc/genre_movie_list/genre_movie_list_bloc.dart';
import 'package:moviehub/feature/search/widget/search_movie_widget.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';

class GenreMovieListView extends StatelessWidget {
  final int? genreId;
  const GenreMovieListView({
    super.key,
    required this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<GenreMovieListBloc>(param1: genreId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movie List"),
        ),
        body: Padding(
          padding: AppDefaults.kPageSidePadding,
          child: BlocBuilderView<GenreMovieListBloc, GenreMovieListState, GenreMovieListLoaded>(
            child: (context, state) {
              if (state.movies.isEmpty) {
                return const CenterHintText(text: "No movies found");
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 14),
                itemBuilder: (context, index) => SearchMovieWidget(movie: state.movies[index]),
                separatorBuilder: (context, index) => FormSeperatorBox(),
                itemCount: state.movies.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/search/widget/search_movie_widget.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/load_page_widget.dart';

class GenreMovieListView extends StatefulWidget {
  final int? genreId;
  const GenreMovieListView({
    Key? key,
    required this.genreId,
  }) : super(key: key);

  @override
  State<GenreMovieListView> createState() => _GenreMovieListViewState();
}

class _GenreMovieListViewState extends State<GenreMovieListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie List"),
      ),
      body: Padding(
        padding: AppDefaults.kPageSidePadding,
        child: LoadPageWidget<List<MovieModel>>(
          futureFunction: locator<MovieService>().searchMovie("", widget.genreId),
          builder: (context, data) {
            if (data.isEmpty) {
              return const CenterHintText(
                text: ("No movies found"),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 14),
              itemBuilder: (context, index) => SearchMovieWidget(movie: data[index]),
              separatorBuilder: (context, index) => FormSeperatorBox(),
              itemCount: data.length,
            );
          },
        ),
      ),
    );
  }
}

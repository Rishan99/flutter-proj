import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/bloc/view/bloc_builder_view.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/search/bloc/search_bloc.dart';
import 'package:moviehub/feature/search/widget/search_movie_widget.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 1), onSearch);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  onSearch() {
    hideKeyboard(context);
    searchBloc.add(
      PerformSearch(""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SearchBloc>(),
      child: Builder(builder: (context) {
        searchBloc = context.read<SearchBloc>();
        return Padding(
          padding: AppDefaults.kPageSidePadding,
          child: Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : CustomInkWell(
                          onTap: () {
                            _searchController.clear();
                            onSearch();
                          },
                          child: Icon(
                            Icons.close,
                          )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            body: BlocBuilderView<SearchBloc, SearchState, SearchLoaded>(
              child: (context, state) => state.movies.isEmpty
                  ? CenterHintText(text: "No Movies Found")
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      itemBuilder: (context, index) => SearchMovieWidget(movie: state.movies[index]),
                      separatorBuilder: (context, index) => FormSeperatorBox(),
                      itemCount: state.movies.length,
                    ),
            ),
          ),
        );
      }),
    );
  }
}

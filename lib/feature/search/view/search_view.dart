import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/search/widget/search_movie_widget.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/load_page_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        body: LoadPageWidget<List<MovieModel>>(
          futureFunction: locator<MovieService>().searchMovie(_searchController.text, null),
          builder: (context, p1) => ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 14),
            itemBuilder: (context, index) => SearchMovieWidget(movie: p1[index]),
            separatorBuilder: (context, index) => FormSeperatorBox(),
            itemCount: p1.length,
          ),
        ),
      ),
    );
  }
}

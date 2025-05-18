import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/genre/model/genre_model.dart';
import 'package:moviehub/feature/genre/widget/genre_widget.dart';
import 'package:moviehub/services/general/general_service.dart';
import 'package:moviehub/widgets/load_page_widget.dart';

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
        child: LoadPageWidget<List<GenreModel>>(
          futureFunction: locator<GeneralService>().getGenres(),
          builder: (context, data) {
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18.sp,
                crossAxisSpacing: 18.sp,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) => GenreWidget(
                data: data[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

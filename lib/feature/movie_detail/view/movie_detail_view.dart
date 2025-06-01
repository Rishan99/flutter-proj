// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/theme/app_colors.dart';
import 'package:moviehub/core/utility/utilities.dart';

import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/movie_detail/widget/about_movie_widget.dart';
import 'package:moviehub/feature/movie_detail/widget/label_widget.dart';
import 'package:moviehub/feature/movie_detail/widget/rate_movie_widget.dart';
import 'package:moviehub/feature/movie_detail/widget/reviews_list_widget.dart';
import 'package:moviehub/feature/wishlist/widget/wishlist_widget.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/image_widget.dart';
import 'package:moviehub/widgets/load_page_widget.dart';
import 'package:moviehub/widgets/wishlist_icon.dart';

class MovieDetailView extends StatefulWidget {
  final int id;
  const MovieDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> with TickerProviderStateMixin {
  late TabController tabController;
  double get backgroundIamgeHeight => 450.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  showRatingDialog(BuildContext context) {
    showBottomSheetCustom(context, RateMovieWidget(movieId: widget.id), title: "Rate this movie");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRatingDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<MovieModel>(
          future: locator<MovieService>().getDetailById(widget.id),
          builder: (context, snapshot) {
            return LoadPageWidget<MovieModel>(
              futureFunction: locator<MovieService>().getDetailById(widget.id),
              builder: (context, data) => Column(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      backgroundWidget(data),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                        height: backgroundIamgeHeight,
                        width: double.maxFinite,
                        child: headerWidget(data),
                      )
                    ],
                  ),
                  Expanded(child: bodyView(data))
                ],
              ),
            );
          }),
    );
  }

  Widget bodyView(MovieModel data) {
    return Padding(
        padding: AppDefaults.kPageSidePadding,
        child: Column(
          children: [
            TabBar(
              tabs: [Tab(text: "About Movie"), Tab(text: "Reviews")],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                AboutMovieWidget(
                  movie: data,
                ),
                ReviewsListWidget(
                  movie: data,
                )
              ],
            )),
          ],
        ));
  }

  Widget headerWidget(MovieModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDefaults.kPageSidePadding.right),
              child: WishlistIcon(
                movieId: data.id,
              ),
            )
          ],
          title: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        Expanded(
          child: Padding(
            padding: AppDefaults.kPageSidePadding,
            child: Column(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 250.sp,
                      maxWidth: 250.sp,
                    ),
                    child: ImageWidget(
                      imageUrl: data.coverImage,
                      // width: 2
                      // height: 250.sp,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FormSeperatorBox(
                  height: 15,
                ),
                SizedBox(
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 0,
                    children: [
                      LabelWidget(
                        icon: Icons.calendar_month_sharp,
                        label: DateTime.parse(data.releaseDate).year.toString(),
                      ),
                      VerticalDivider(),
                      LabelWidget(
                        icon: Icons.timer,
                        label: "${data.runtime} Minutes",
                      ),
                      VerticalDivider(),
                      LabelWidget(
                        icon: MdiIcons.filmstrip,
                        label: data.genre,
                      ),
                      VerticalDivider(),
                      LabelWidget(
                        icon: Icons.star,
                        label: data.averageRating.toString(),
                        iconColor: Colors.amber,
                      )
                    ],
                  ),
                ),
                FormSeperatorBox(
                  height: 15,
                ),
                if (data.movieLink != null || data.trailerLink != null) ...[
                  trailerMovieButton(data),
                  FormSeperatorBox(
                    height: 15,
                  ),
                ]
              ],
            ),
          ),
        )
      ],
    );
  }

  ButtonStyle buttonStyle(Color color) => ButtonStyle(
      minimumSize: WidgetStateProperty.resolveWith(
        (x) => Size(100.w, AppDefaults.buttonHeight),
      ),
      shape: WidgetStateProperty.resolveWith(
        (x) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.sp),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((x) => color));
  Widget trailerMovieButton(MovieModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (data.trailerLink != null)
          OutlinedButton.icon(
              style: buttonStyle(Colors.transparent),
              onPressed: () {
                openLink(data.trailerLink!);
              },
              label: Text("Trailer"),
              icon: Icon(
                Icons.play_arrow,
              )),
        if (!(data.trailerLink == null || data.movieLink == null)) adaptableWidth(width: 16),
        if (data.movieLink != null)
          TextButton.icon(
            onPressed: () {
              openLink(data.movieLink!);
            },
            label: Text("Movie"),
            icon: Icon(
              Icons.play_arrow,
            ),
            style: buttonStyle(AppColors.secondary),
          ),
      ],
    );
  }

  Widget backgroundWidget(MovieModel data) {
    return ImageWidget(
      imageUrl: data.coverImage,
      width: double.infinity,
      height: backgroundIamgeHeight,
      fit: BoxFit.cover,
    );
  }
}

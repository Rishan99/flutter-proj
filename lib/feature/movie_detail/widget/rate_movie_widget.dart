// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/utility/validator.dart';
import 'package:moviehub/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:moviehub/feature/movie_detail/bloc/rating/rate_movie_bloc.dart';
import 'package:moviehub/shared/widgets/form_seperator_box.dart';
import 'package:moviehub/shared/widgets/rating_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:moviehub/dependency_inject.dart';

class RateMovieWidget extends StatefulWidget {
  final int movieId;
  const RateMovieWidget({
    super.key,
    required this.movieId,
  });

  @override
  State<RateMovieWidget> createState() => _RateMovieWidgetState();
}

class _RateMovieWidgetState extends State<RateMovieWidget> {
  double rating = 4;
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RateMovieBloc>(param1: widget.movieId),
      child: BlocListener<RateMovieBloc, RateMovieState>(
        listener: (context, state) async {
          if (state is RateMovieLoading) {
            ProgressDialog progressDialog = ProgressDialog(context);
            await progressDialog.show();
          } else {
            Navigator.of(context).pop();
            context.read<MovieDetailBloc>().add(FetchMovieDetail());
            if (state is RateMovieSuccess) {
              displayToastSuccess("Rating submitted successfully");
              Navigator.of(context).pop();
            } else if (state is RateMovieError) {
              displayToastFailure(state.message);
            }
          }
        },
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FormSeperatorBox(),
              RatingWidget(
                size: 28.sp,
                rating: rating,
                onUpdate: (p0) {
                  setState(() {
                    rating = p0;
                  });
                },
              ),
              FormSeperatorBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 12,
                minLines: 10,
                validator: Validators.emptyFieldValidator,
                controller: descriptionController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  hintText: "Write description here...",
                ),
              ),
              FormSeperatorBox(
                height: 20,
              ),
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() == false) {
                      return;
                    }
                    BlocProvider.of<RateMovieBloc>(context).add(
                      SubmitRating(
                        rating: rating,
                        description: descriptionController.text,
                      ),
                    );
                  },
                  child: Text("Submit"),
                );
              }),
              FormSeperatorBox(),
            ],
          ),
        ),
      ),
    );
  }
}

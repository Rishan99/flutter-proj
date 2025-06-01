// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/utility/validator.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/services/movie/movie_service.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/rating_widget.dart';

class RateMovieWidget extends StatefulWidget {
  final int movieId;
  const RateMovieWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<RateMovieWidget> createState() => _RateMovieWidgetState();
}

class _RateMovieWidgetState extends State<RateMovieWidget> {
  double rating = 4;
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
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
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: "Write description here...",
            ),
          ),
          FormSeperatorBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate() == false) {
                return;
              }
              asyncCallHelperWithLoadingBar(context, processCall: () async {
                return await locator<MovieService>().rate(
                  widget.movieId,
                  rating,
                  descriptionController.text,
                );
              }, onSuccess: (x) {
                displayToastSuccess(x.toString());
                Navigator.of(context).pop();
              });
            },
            child: Text("Submit"),
          ),
          FormSeperatorBox(),
        ],
      ),
    );
  }
}

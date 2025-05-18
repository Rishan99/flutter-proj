// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';

import 'package:moviehub/shared/model/cast_model.dart';
import 'package:moviehub/widgets/circular_image_widget.dart';

class CastWidget extends StatelessWidget {
  final CastModel cast;
  const CastWidget({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularImageWidget(),
        adaptableWidth(width: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cast.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              cast.type,
              style: TextStyle(
                color: Color(0xff92929D),
                fontSize: 12,
              ),
            )
          ],
        ))
      ],
    );
  }
}

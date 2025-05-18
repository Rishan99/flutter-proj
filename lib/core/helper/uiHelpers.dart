import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/widgets/error_dialog_widget.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toastification/toastification.dart';

// import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

Future<dynamic> showBottomSheetCustom(BuildContext context, Widget widget, {String? title, bool? isDismiss, bool? dragEnable}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    isDismissible: isDismiss ?? true,
    enableDrag: dragEnable ?? true,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      padding: MediaQuery.viewInsetsOf(context).add(AppDefaults.kPageSidePadding).add(const EdgeInsets.symmetric(vertical: 12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            Expanded(
              child: (title != null)
                  ? Text(
                      title,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp),
                    )
                  : const SizedBox.shrink(),
            ),
            CloseButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        widget,
        SizedBox(
          height: 8.h,
        ),
      ]),
    ),
  );
}

_overlaySupprt(String message, ToastificationType type) {
  toastification.show(
      title: Text(
        message,
        maxLines: 3,
      ),
      style: ToastificationStyle.fillColored,
      showIcon: false,
      type: type,
      autoCloseDuration: const Duration(seconds: 3),
      closeOnClick: true,
      alignment: Alignment.bottomCenter);
}

displayToastFailure(String message) {
  _overlaySupprt(message, ToastificationType.error);
}

displayToastSuccess(String message) {
  _overlaySupprt(message, ToastificationType.success);
}

SizedBox adaptableHeight({double height = 15}) => SizedBox(height: height.h);
SizedBox adaptableWidth({double width = 15}) => SizedBox(width: width.w);

Widget homeSeperatorBox() => const FormSeperatorBox(height: 35);
Widget homeTitleContentSeperatorBox() => const FormSeperatorBox(height: 20);

Future<dynamic> showAlertDialog(BuildContext context, String title, String content, {Function()? onConfirmPress, Function()? onCancelPress}) async {
  return await showDialog(
      context: context,
      builder: (x) {
        return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: AppDefaults.kPageSidePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ErrorDialogWidget(
              content: content,
              title: title,
              onCancelPress: onCancelPress,
              onConfirmPress: onConfirmPress,
            ));
      });
}

void asyncCallHelperWithLoadingBar(BuildContext context, {required Future<dynamic> Function() processCall, required Function onSuccess, Function(Object)? onError}) async {
  ProgressDialog pr = ProgressDialog(context);

  await pr.show();
  try {
    var response = await processCall();
    await pr.hide();
    if (response == null) {
      onSuccess();
    } else {
      onSuccess(response);
    }
  } catch (ex) {
    await pr.hide();
    try {} catch (ex) {
      debugPrint("object");
      //
    }

    if (onError == null) {
      displayToastFailure(ex.toString());
    } else {
      onError(ex);
    }
  }
}

Widget movieReleaseOrNotChip(DateTime releaseDate) {
  var isReleased = releaseDate.isBefore(DateTime.now());
  return Chip(
      // side: BorderSide.none,
      // labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      label: Text(isReleased ? "Released" : "Cmming Soon"),
      backgroundColor: isReleased ? AppColors.primary : AppColors.secondary,
      labelStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)));
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF12CDD9);
  static const primaryBackgroundShade = Color(0xff05E9F7);

  static const secondary = Color(0xffFF8700);

  static const blueHighlightColor = Color(0xFF3E97FF);
  static const blueHighlightyBackgroundShade = Color(0xffB8E3DB);
  static const blueHighlightBackgroundShade2 = Color(0xffE2F1FF);

  static const bottomBarSelectedColor = primary;
  static const tabLabelBoxColor = Color(0xff252836);
  static MaterialColor primaryMaterialColor = MaterialColor(primary.value, const {
    50: primary,
    100: primary,
    200: primary,
    300: primary,
    400: primary,
    500: primary,
    600: primary,
    700: primary,
    800: primary,
    900: primary,
  });

  static const cardBackgroundColor = Color(0xff252836);
  static const greenColor = Color(0xff50CD89);
  static const greenBackgroundShade = Color(0xffB3FADE);
  static const greenBackgroundShade2 = Color(0xffEFFDF7);

  static const deliveredColor = Color(0xff0CA76B);

  static const starColor = Color(0xffF6C000);
  static const starColorBackgroundShade2 = Color(0xffFFF8DD);

  static const discountHighlightColor = Color(0xffF6C000);
  static const discountBackgroundShade2 = Color(0xffFFF8DD);

  static const pendingColor = Color(0xffFFA337);
  static const pendingBackgroundShade2 = Color(0xffFFE0AD);
  static const pendingBackgroundShade = Color(0xffFFF5E9);

  static const receivedAmountColor = Color(0xffB3FADE);
  static const receivedAmountBackgroundShade = Color(0xffEFFDF7);

  static const expiredColor = Color(0xffF1416C);
  static const deleteColor = Color(0xffF1416C);
  static const deleteColorShade = Color(0xffFFF5F8);
  static const returnBackgroundShade = Color(0xffFFD5E2);
  static const returnBackgroundShade2 = Color(0xffFCEBEB);

  static Color get cancelColor => secondary;

  static const totalVoucherColor = Color(0xffFFD5E2);
  static const totalVoucherBackgroundShade = Color(0xffFCEBEB);

  static const commissionExpenseColor = Color(0xffB6DDFF);
  static const commissionExpenseBackgroundShade = Color(0xffE2F1FF);

  static const headingLargeColor = Color(0xff181C32);
  static const headingColor = Color(0xff181C32);
  static const headingSmallColor = Color(0xff5E6278);

/* Text Colors */
  static const kHintColorText = Color(0xFF7E8299);

  static final kColorError = Colors.red[800]!;
  static const kColorBackground = Color(0xff1F1D2B);

  static const kColorBackgroundSecondary = Color(0xffF9F9F9);
  static const kColorButtonPrimary = kPrimaryButton;
  static get kColorButtonSecondary => secondary;
  static const kColorOutlineButton = Color(0xffFAFAFA);
  static const kColorOutlineButtonBorder = Color(0xffECEBEC);
  static const kColorDottedBorder = Color(0xffD8D8E5);
  static const kCheckBoxBorder = Color(0xffBFBBBD);
  static const kBorderColor = Color(0xffE1E3EA);
  static const kInputDecorationIconColor = Color(0xff7E8299);

  static const kColorDivier = kColorOutlineButtonBorder;

  static const kChipSelectedColor = primary;
  static const kChipUnselectedColor = kColorOutlineButton;

  static const LinearGradient goldCardGradient = LinearGradient(colors: [Color(0xffFFCF54), Color(0xffFFE382), Color(0xffFFCF54)]);
  static const LinearGradient silverCardGradient = LinearGradient(colors: [Color(0xffE0E0E0), Color(0xffF4F4F4), Color(0xffD4D4D4)]);
}

import 'package:flutter/material.dart';
import 'colors_constants.dart';
import 'numbers.dart';

abstract class TextStyles {
  static const TextStyle movieCardTitleTextStyle = TextStyle(
    fontSize: Numbers.movieCardTitleFontSize,
    color: ColorsConstants.appThemeColor,
    decoration: TextDecoration.underline,
  );
  static const TextStyle generalTextStyle = TextStyle(
    fontSize: Numbers.bigXTextSize,
  );
  static const TextStyle imagesPageDefaultMessageTextStyle = TextStyle(
    fontSize: Numbers.bigXTextSize,
    color: Colors.white,
  );
  static const TextStyle imagesPageTitleTextStyle = TextStyle(
    fontSize: Numbers.bigTextSize,
  );
  static const TextStyle imagesPageSnackBarTextStyle = TextStyle(
    fontSize: Numbers.mediumXTextSize,
  );
  static const TextStyle mapPageMarkerTextStyle = TextStyle(
    fontSize: Numbers.mediumTextSize,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle noSuccessMessageTextStyle = TextStyle(
    fontSize: Numbers.noSuccessMessageFontSize,
    color: ColorsConstants.appThemeColor,
    fontWeight: FontWeight.bold,
  );
}

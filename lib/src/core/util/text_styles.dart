import 'package:flutter/material.dart';
import 'colors_constants.dart';
import 'numbers.dart';

abstract class TextStyles {
  static const TextStyle movieCardTitleTextStyle = TextStyle(
    fontSize: Numbers.movieCardTitleFontSize,
    color: ColorsConstants.appThemeColor,
    decoration: TextDecoration.underline,
  );
  static const TextStyle noSuccessMessageTextStyle = TextStyle(
    fontSize: Numbers.noSuccessMessageFontSize,
    color: ColorsConstants.appThemeColor,
    fontWeight: FontWeight.bold,
  );
}

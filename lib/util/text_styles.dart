import 'package:flutter/material.dart';
import 'numbers.dart';

abstract class TextStyles {
  static const TextStyle styleMovieTitle = TextStyle(
    fontSize: Numbers.textStyleFontSize,
    color: Colors.blueGrey,
    decoration: TextDecoration.underline,
  );
}

import 'package:flutter/material.dart';
import '../../core/util/colors_constants.dart';
import '../../core/util/text_styles.dart';

class MovieButton extends StatelessWidget {
  const MovieButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(
          key: key,
        );

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.appThemeColor,
      ),
      child: Text(
        text,
        style: TextStyles.generalTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

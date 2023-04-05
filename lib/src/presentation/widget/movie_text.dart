import 'package:flutter/material.dart';
import '../../core/util/numbers.dart';
import '../../core/util/text_styles.dart';

class MovieText extends StatelessWidget {
  const MovieText({
    Key? key,
    required this.text,
  }) : super(
          key: key,
        );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          Numbers.mediumPadding,
        ),
        child: Text(
          text,
          style: TextStyles.noSuccessMessageTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

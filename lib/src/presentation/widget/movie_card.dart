import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/util/assets.dart';
import '../../core/util/colors_constants.dart';
import '../../core/util/numbers.dart';
import '../../core/util/text_styles.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(
          key: key,
        );

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsConstants.appThemeColor,
          width: Numbers.movieCardBorderWidth,
        ),
        borderRadius: BorderRadius.circular(
          Numbers.movieCardBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          Numbers.smallXPadding,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.movieCardTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: Numbers.movieCardSizedBox,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    Numbers.movieCardBorderRadius,
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    Assets.movieCardDefaultThumbImage,
                    width: Numbers.movieCardDefaultImageSize,
                    height: Numbers.movieCardDefaultImageSize,
                  ),
                  imageUrl: image,
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.movieCardDefaultThumbImage,
                    width: Numbers.movieCardDefaultImageSize,
                    height: Numbers.movieCardDefaultImageSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

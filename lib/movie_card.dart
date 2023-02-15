import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/util/numbers.dart';
import 'package:movies_app/util/strings.dart';
import 'util/text_styles.dart';

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
          color: Colors.blueGrey,
          width: Numbers.movieCardBorderWidth,
        ),
        borderRadius: BorderRadius.circular(
          Numbers.movieCardBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          Numbers.movieCardPadding,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.styleMovieTitle,
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
                    Strings.movieCardImageError,
                    width: Numbers.movieCardCachedNetworkImageSize,
                    height: Numbers.movieCardCachedNetworkImageSize,
                  ),
                  imageUrl: image,
                  errorWidget: (context, url, error) => Image.asset(
                    Strings.movieCardImageError,
                    width: Numbers.movieCardCachedNetworkImageSize,
                    height: Numbers.movieCardCachedNetworkImageSize,
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

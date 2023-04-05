import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/src/core/util/strings.dart';
import 'package:movies_app/src/presentation/widget/movie_button.dart';
import '../../core/util/assets.dart';
import '../../core/util/colors_constants.dart';
import '../../core/util/numbers.dart';
import '../../core/util/text_styles.dart';
import '../bloc/images_bloc.dart';

class ImagesPage extends StatefulWidget {
  ImagesPage({
    Key? key,
    required this.title,
  }) : super(
          key: key,
        );

  final String title;
  final ImagesBloc imagesBloc = Get.find<ImagesBloc>();

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  @override
  void initState() {
    super.initState();
    widget.imagesBloc.initialize();
  }

  @override
  void dispose() {
    widget.imagesBloc.dispose();
    super.dispose();
  }

  Widget _defaultMessage(String text) {
    return Container(
      color: ColorsConstants.appThemeColor,
      width: Numbers.imagesPageWidth,
      height: Numbers.imagesPageHeight,
      child: Center(
        child: Text(
          text,
          style: TextStyles.imagesPageDefaultMessageTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _showSelectedImages() {
    return StreamBuilder<List<File>>(
      stream: widget.imagesBloc.deviceImagesStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<File>> snapshot,
      ) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return _defaultMessage(
                Strings.imagesPageDefaultMessageDeviceImages);
          } else {
            return Container(
              color: ColorsConstants.appThemeColor,
              width: Numbers.imagesPageWidth,
              height: Numbers.imagesPageHeight,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      Numbers.smallXPadding,
                    ),
                    child: SizedBox(
                      width: Numbers.imagesPageWidthSizedBox,
                      height: Numbers.imagesPageHeightSizedBox,
                      child: Image.file(
                        snapshot.data![index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return _defaultMessage(Strings.imagesPageDefaultMessageDeviceImages);
        }
      },
    );
  }

  Widget _showStoredImages() {
    return StreamBuilder<List<String>>(
      stream: widget.imagesBloc.storageImagesStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<String>> snapshot,
      ) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return _defaultMessage(
                Strings.imagesPageDefaultMessageStorageImages);
          } else {
            return Container(
              color: ColorsConstants.appThemeColor,
              width: Numbers.imagesPageWidth,
              height: Numbers.imagesPageHeight,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      Numbers.smallXPadding,
                    ),
                    child: SizedBox(
                      width: Numbers.imagesPageWidthSizedBox,
                      height: Numbers.imagesPageHeightSizedBox,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Image.asset(
                          Assets.movieCardDefaultThumbImage,
                          fit: BoxFit.fill,
                        ),
                        imageUrl: snapshot.data![index],
                        errorWidget: (context, url, error) => Image.asset(
                          Assets.movieCardDefaultThumbImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return _defaultMessage(Strings.imagesPageDefaultMessageStorageImages);
        }
      },
    );
  }

  _openGallery(BuildContext context) async {
    widget.imagesBloc.getGalleryImages();
  }

  _openCamera(BuildContext context) async {
    widget.imagesBloc.getCameraImages();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          return AlertDialog(
            title: const Text(
              Strings.imagesPageSelect,
              style: TextStyles.generalTextStyle,
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  MovieButton(
                      text: Strings.imagesPageGallery,
                      onPressed: () {
                        _openGallery(context);
                        Navigator.of(context).pop();
                      }),
                  const Padding(
                    padding: EdgeInsets.all(
                      Numbers.smallPadding,
                    ),
                  ),
                  MovieButton(
                      text: Strings.imagesPageCamera,
                      onPressed: () {
                        _openCamera(context);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: Numbers.imagesPageSizedBox,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: Numbers.smallPadding,
                ),
                child: Text(
                  Strings.imagesPageTitleDeviceImages,
                  style: TextStyles.imagesPageTitleTextStyle,
                ),
              ),
              _showSelectedImages(),
              const SizedBox(
                height: Numbers.imagesPageSizedBox,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: Numbers.smallPadding,
                ),
                child: Text(
                  Strings.imagesPageTitleStorageImages,
                  style: TextStyles.imagesPageTitleTextStyle,
                ),
              ),
              _showStoredImages(),
              const SizedBox(
                height: Numbers.imagesPageSizedBox,
              ),
              MovieButton(
                text: Strings.imagesPageTextButtonDeviceImages,
                onPressed: () {
                  _showChoiceDialog(context);
                },
              ),
              const SizedBox(
                height: Numbers.imagesPageSizedBox,
              ),
              MovieButton(
                text: Strings.imagesPageTextButtonStorageImages,
                onPressed: () async {
                  widget.imagesBloc.getStorageImages();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorsConstants.appThemeColor,
                      content: Text(
                        widget.imagesBloc.hasSelectedImages()
                            ? Strings.imagesPageSnackBarWithImages
                            : Strings.imagesPageSnackBarWithoutImages,
                        style: TextStyles.imagesPageSnackBarTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

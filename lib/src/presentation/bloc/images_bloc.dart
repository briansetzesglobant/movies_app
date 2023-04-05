import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/src/data/data_source/local/images_storage.dart';
import '../../core/bloc/bloc.dart';

class ImagesBloc extends Bloc {
  ImagePicker imagePicker = ImagePicker();
  XFile? picture;
  File? image;
  late List<File> imagesList;
  late List<String> urlsList;
  final ImagesStorage imagesStorage = Get.find<ImagesStorage>();

  late StreamController<List<File>> _deviceImagesStreamController;
  late StreamController<List<String>> _storageImagesStreamController;

  Stream<List<File>> get deviceImagesStream =>
      _deviceImagesStreamController.stream;

  Stream<List<String>> get storageImagesStream =>
      _storageImagesStreamController.stream;

  @override
  Future<void> initialize() async {
    imagesList = [];
    urlsList = [];
    _deviceImagesStreamController = StreamController();
    _storageImagesStreamController = StreamController();
  }

  @override
  void dispose() {
    _deviceImagesStreamController.close();
    _storageImagesStreamController.close();
  }

  bool hasSelectedImages() => imagesList.isNotEmpty;

  void _getImages(ImageSource source) async {
    picture = await imagePicker.pickImage(source: source);
    if (picture != null) {
      image = File(picture!.path);
      imagesList.add(File(picture!.path));
    }
    urlsList = [];
    _deviceImagesStreamController.sink.add(imagesList);
    _storageImagesStreamController.sink.add(urlsList);
  }

  void getGalleryImages() {
    _getImages(ImageSource.gallery);
  }

  void getCameraImages() async {
    _getImages(ImageSource.camera);
  }

  void getStorageImages() async {
    urlsList = await imagesStorage.uploadImages(imagesList);
    imagesList = [];
    _storageImagesStreamController.sink.add(urlsList);
    _deviceImagesStreamController.sink.add(imagesList);
  }
}

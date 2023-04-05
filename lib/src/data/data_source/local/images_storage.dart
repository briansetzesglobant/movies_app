import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:movies_app/src/core/util/strings.dart';

class ImagesStorage {
  ImagesStorage._privateConstructor();

  static final ImagesStorage instance = ImagesStorage._privateConstructor();

  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> imagesList) async {
    List<String> urlsList = [];
    String nameFile;
    Reference reference;
    UploadTask uploadTask;
    TaskSnapshot snapshot;
    String url;
    for (var image in imagesList) {
      nameFile = image.path.split(Strings.imageStorageCache).last;
      reference = _firebaseStorage
          .ref()
          .child(Strings.imageStorageImages)
          .child(nameFile);
      uploadTask = reference.putFile(image);
      snapshot = await uploadTask.whenComplete(() => true);
      url = await snapshot.ref.getDownloadURL();
      urlsList.add(url);
    }
    return urlsList;
  }
}

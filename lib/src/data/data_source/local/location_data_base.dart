import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/src/data/model/location_model.dart';
import '../../../core/util/strings.dart';

class LocationDatabase {
  LocationDatabase._privateConstructor();

  static final LocationDatabase instance =
      LocationDatabase._privateConstructor();

  static final FirebaseFirestore _instanceFirestore =
      FirebaseFirestore.instance;

  static final CollectionReference _locationCollection =
      _instanceFirestore.collection(Strings.locationCollectionName);

  Future<void> insertLocation(LocationModel location) async {
    await _locationCollection.doc('${location.date}').set(
          LocationModel(
            latitude: location.latitude,
            longitude: location.longitude,
            date: location.date,
          ).toJson(),
        );
  }

  Future<List<LocationModel>> getLocations() async {
    List<LocationModel> locations = [];
    QuerySnapshot querySnapshot = await _locationCollection.get();
    for (var doc in querySnapshot.docs) {
      try {
        locations.add(
          LocationModel.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        );
      } catch (e) {
        rethrow;
      }
    }
    return locations;
  }
}

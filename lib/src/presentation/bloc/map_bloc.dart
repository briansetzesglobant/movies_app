import 'dart:async';
import 'package:get/get.dart';
import 'package:movies_app/src/data/data_source/local/location_data_base.dart';
import 'package:movies_app/src/data/model/location_model.dart';
import '../../core/bloc/bloc.dart';

class MapBloc extends Bloc {
  final LocationDatabase locationDatabase = Get.find<LocationDatabase>();

  late StreamController<List<LocationModel>> _locationsStreamController;

  Stream<List<LocationModel>> get locationsStream =>
      _locationsStreamController.stream;

  @override
  Future<void> initialize() async {
    _locationsStreamController = StreamController();
  }

  @override
  void dispose() {
    _locationsStreamController.close();
  }

  void insertLocation(LocationModel location) async {
    locationDatabase.insertLocation(location);
    if (!_locationsStreamController.isClosed) {
      getLocations();
    }
  }

  void getLocations() async {
    final locations = await locationDatabase.getLocations();
    _locationsStreamController.sink.add(locations);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:movies_app/src/core/resource/map_notification_service.dart';
import 'package:movies_app/src/core/util/numbers.dart';
import 'package:movies_app/src/core/util/text_styles.dart';
import 'package:movies_app/src/core/resource/map_timer.dart';
import 'package:movies_app/src/data/model/location_model.dart';
import '../../core/util/strings.dart';
import '../bloc/map_bloc.dart';

class MapPage extends StatefulWidget {
  MapPage({
    required this.title,
    Key? key,
  }) : super(
          key: key,
        );

  final String title;
  final MapBloc mapBloc = Get.find<MapBloc>();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;

  @override
  void initState() {
    super.initState();
    _checkService();
    _checkPermission();
    location.enableBackgroundMode(enable: true);
    widget.mapBloc.initialize();
    widget.mapBloc.getLocations();
    _track();
  }

  @override
  void dispose() {
    widget.mapBloc.dispose();
    super.dispose();
  }

  void _track() {
    MapTimer.getInstance((_) async {
      final LocationData locationData = await location.getLocation();
      widget.mapBloc.insertLocation(
        LocationModel(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
          date: locationData.time,
        ),
      );
      showNotification();
    });
  }

  void _checkService() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
  }

  void _checkPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Widget _getMap(List<LocationModel> locations) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          Numbers.mapPageInitialLatitude,
          Numbers.mapPageInitialLongitude,
        ),
        zoom: Numbers.mapPageZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: Strings.mapOpenStreetMap,
          userAgentPackageName: Strings.mapExample,
        ),
        MarkerLayer(
          markers: locations
              .map(
                (location) => Marker(
                  width: Numbers.mapPageMarkerWidth,
                  height: Numbers.mapPageMarkerHeight,
                  point: LatLng(
                    location.latitude!,
                    location.longitude!,
                  ),
                  builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: Numbers.smallPadding,
                        ),
                        child: Text(
                          DateFormat(
                            Strings.mapDateFormat,
                          ).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              location.date!.toInt(),
                            ),
                          ),
                          style: TextStyles.mapPageMarkerTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Icon(
                        Icons.pin_drop,
                        size: Numbers.mapPageMarkerIconSize,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: StreamBuilder<List<LocationModel>>(
        stream: widget.mapBloc.locationsStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<LocationModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return _getMap(snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

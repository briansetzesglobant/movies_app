class LocationModel {
  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
    };
  }

  final double? latitude;
  final double? longitude;
  final double? date;
}

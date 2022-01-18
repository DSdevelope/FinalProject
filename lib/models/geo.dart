class Geo {
  final String lat, lng;

  Geo(this.lat, this.lng);

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(json['lat'] as String, json['lng'] as String);

  }

  @override
  String toString() {
    return 'Geo{lat: $lat, lng: $lng}';
  }
}
class Geo {
  final String lat, lng;

  Geo(this.lat, this.lng);

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(json['lat'], json['lng']);

  }

  @override
  String toString() {
    return 'Geo{lat: $lat, lng: $lng}';
  }
}
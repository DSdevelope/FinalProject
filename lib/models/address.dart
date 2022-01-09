import 'package:finalproject/models/geo.dart';

class Address {
  final String
    street,
    suite,
    city,
    zipcode;
  final Geo geo;

  Address(
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        json['street'],
        json['suite'],
        json['city'],
        json['zipcode'],
        Geo.fromJson(json['geo']),
    );
  }

  @override
  String toString() {
    return 'Address{street: $street, suite: $suite, city: $city, zipcode: $zipcode, geo: $geo}';
  }
}
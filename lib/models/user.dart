import 'package:finalproject/models/address.dart';
import 'package:finalproject/models/company.dart';

class User {
  final int id;
  final String
    name,
    username,
    email,
    phone,
    website;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company});

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] as int,
        name: json['name'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        address: Address.fromJson(json['address']),
        phone: json['phone'] as String,
        website: json['website'] as String,
        company: Company.fromJson(json['company']),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email, '
        'phone: $phone, website: $website, address: $address, company: $company}';
  }
}
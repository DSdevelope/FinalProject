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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        address: Address.fromJson(json['address']),
        phone: json['phone'],
        website: json['website'],
        company: Company.fromJson(json['company']),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email, '
        'phone: $phone, website: $website, address: $address, company: $company}';
  }
}
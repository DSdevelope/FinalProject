class Company {
  final String name, catchPhrase, bs;

  Company(this.name, this.catchPhrase, this.bs);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      json['name'] as String,
      json['catchPhrase'] as String,
      json['bs'] as String);
  }
  
  @override
  String toString() {
    return 'Company{name: $name, catchPhrase: $catchPhrase, bs: $bs}';
  }
}
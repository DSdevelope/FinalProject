class Company {
  final String name, catchPhrase, bs;

  Company(this.name, this.catchPhrase, this.bs);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(json['name'], json['catchPhrase'], json['bs']);
  }
  
  @override
  String toString() {
    return 'Company{name: $name, catchPhrase: $catchPhrase, bs: $bs}';
  }
}
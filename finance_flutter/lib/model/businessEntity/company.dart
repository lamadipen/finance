class Company{
  final String id;
  final String name;
  String phone;
  String address;

  Company.allArgs({this.id, this.name, this.phone, this.address});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company.allArgs(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address']
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, phone: $phone, address: $address}';
  }
}
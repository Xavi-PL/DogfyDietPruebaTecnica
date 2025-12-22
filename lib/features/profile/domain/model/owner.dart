// In order to draft an owner, one field must be defined no matter what the order,
//this means that all fields can be null.

class Owner {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;

  const Owner({this.name, this.email, this.phone, this.address});
}

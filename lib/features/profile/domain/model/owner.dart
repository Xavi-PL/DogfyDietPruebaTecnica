// In order to draft an owner, one field must be defined no matter what the order,
//this means that all fields can be null.

enum Country { es, fr, it, de }

class Owner {
  final String? name;
  final String? email;
  final String? phone;
  final Country? country;
  final String? address;

  const Owner({this.name, this.email, this.phone, this.country, this.address});

  Owner copyWith({
    String? name,
    String? email,
    String? phone,
    Country? country,
    String? address,
  }) {
    return Owner(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      address: address ?? this.address,
    );
  }
}

import 'dart:convert';

import 'package:dogfy_diet_prueba_tecnica/core/utils/utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/owner_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

class OwnerMapper {
  OwnerMapper();

  Map<String, dynamic> toMap(OwnerDto? ownerDto) {
    return {
      'name': ownerDto?.name,
      'email': ownerDto?.email,
      'phone': ownerDto?.phone,
      'country': ownerDto?.country,
      'address': ownerDto?.address,
    };
  }

  OwnerDto fromMap(Map<String, dynamic> map) {
    return OwnerDto(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
    );
  }

  Owner toDomain(OwnerDto? ownerDto) {
    return Owner(
      name: ownerDto?.name,
      email: ownerDto?.email,
      phone: ownerDto?.phone,
      country: ownerDto?.country == null
          ? null
          : Utilities.enumFromName<Country>(Country.values, ownerDto?.country),
      address: ownerDto?.address,
    );
  }

  OwnerDto fromDomain(Owner? owner) {
    return OwnerDto(
      name: owner?.name,
      email: owner?.email,
      phone: owner?.phone,
      country: owner?.country?.name,
      address: owner?.address,
    );
  }

  String toJson(OwnerDto ownerDto) => jsonEncode(toMap(ownerDto));

  OwnerDto fromJson(String json) =>
      fromMap(jsonDecode(json) as Map<String, dynamic>);
}

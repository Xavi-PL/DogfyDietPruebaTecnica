import 'dart:convert';

import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/breed_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';

class BreedMapper {
  BreedMapper();

  Map<String, dynamic> toMap(BreedDto? breedDto) {
    return {'id': breedDto?.id, 'name': breedDto?.name};
  }

  BreedDto fromMap(Map<String, dynamic> map) {
    return BreedDto(id: map['id'] as int, name: map['name'] as String);
  }

  Breed toDomain(BreedDto breedDto) {
    return Breed(id: breedDto.id, name: breedDto.name);
  }

  BreedDto fromDomain(Breed breed) {
    return BreedDto(id: breed.id, name: breed.name);
  }

  String toJson(BreedDto? breedDto) => jsonEncode(toMap(breedDto));

  BreedDto fromJson(String json) =>
      fromMap(jsonDecode(json) as Map<String, dynamic>);

  List<BreedDto> fromJsonList(Map<String, dynamic> json) =>
      (json['breeds'] as List<dynamic>)
          .map((breedJson) => fromMap(breedJson))
          .toList();
}

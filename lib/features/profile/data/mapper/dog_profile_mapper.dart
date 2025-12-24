import 'dart:convert';

import 'package:dogfy_diet_prueba_tecnica/core/utils/utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/mapper/breed_mapper.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/mapper/owner_mapper.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/dog_profile_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class DogProfileMapper {
  DogProfileMapper();

  Map<String, dynamic> toMap(DogProfileDto dogProfileDto) {
    return {
      'breed': BreedMapper().toMap(dogProfileDto.breed),
      'name': dogProfileDto.name,
      'sex': dogProfileDto.sex,
      'sterilized': dogProfileDto.sterilized,
      'birthMonth': dogProfileDto.birthMonth,
      'birthYear': dogProfileDto.birthYear,
      'size': dogProfileDto.size,
      'weight': dogProfileDto.weight,
      'activity': dogProfileDto.activity,
      'hasIllness': dogProfileDto.hasIllness,
      'gastronomy': dogProfileDto.gastronomy,
      'owner': OwnerMapper().toMap(dogProfileDto.owner),
    };
  }

  DogProfileDto fromMap(Map<String, dynamic> map) {
    return DogProfileDto(
      breed: map['breed'] == null
          ? null
          : BreedMapper().fromMap(map['breed'] as Map<String, dynamic>),
      name: map['name'] as String?,
      sex: map['sex'] as String?,
      sterilized: map['sterilized'] as bool?,
      birthMonth: map['birthMonth'] as int?,
      birthYear: map['birthYear'] as int?,
      size: map['size'] as String?,
      weight: (map['weight'] as num?)?.toDouble(),
      activity: map['activity'] as String?,
      hasIllness: map['hasIllness'] as bool?,
      gastronomy: map['gastronomy'] as String?,
      owner: map['owner'] == null
          ? null
          : OwnerMapper().fromMap(map['owner'] as Map<String, dynamic>),
    );
  }

  DogProfile toDomain(DogProfileDto dogProfileDto) {
    return DogProfile(
      breed: BreedMapper().toDomain(dogProfileDto.breed),
      name: dogProfileDto.name,
      sex: Utilities.enumFromName<DogSex>(DogSex.values, dogProfileDto.sex),
      sterilized: dogProfileDto.sterilized,
      birthMonth: dogProfileDto.birthMonth,
      birthYear: dogProfileDto.birthYear,
      size: Utilities.enumFromName<DogSize>(DogSize.values, dogProfileDto.size),
      weight: dogProfileDto.weight,
      activity: Utilities.enumFromName<DogActivity>(
        DogActivity.values,
        dogProfileDto.activity,
      ),
      hasIllness: dogProfileDto.hasIllness,
      gastronomy: Utilities.enumFromName<DogGastronomy>(
        DogGastronomy.values,
        dogProfileDto.gastronomy,
      ),
      owner: OwnerMapper().toDomain(dogProfileDto.owner),
    );
  }

  DogProfileDto fromDomain(DogProfile dogProfile) {
    return DogProfileDto(
      breed: dogProfile.breed == null
          ? null
          : BreedMapper().fromDomain(dogProfile.breed),
      name: dogProfile.name,
      sex: dogProfile.sex?.name,
      sterilized: dogProfile.sterilized,
      birthMonth: dogProfile.birthMonth,
      birthYear: dogProfile.birthYear,
      size: dogProfile.size?.name,
      weight: dogProfile.weight,
      activity: dogProfile.activity?.name,
      hasIllness: dogProfile.hasIllness,
      gastronomy: dogProfile.gastronomy?.name,
      owner: dogProfile.owner == null
          ? null
          : OwnerMapper().fromDomain(dogProfile.owner),
    );
  }

  String toJson(DogProfileDto dogProfileDto) =>
      jsonEncode(toMap(dogProfileDto));

  DogProfileDto fromJson(String json) =>
      fromMap(jsonDecode(json) as Map<String, dynamic>);
}

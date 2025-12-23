import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

enum DogSex { male, female }

enum DogSize { small, medium, big }

enum DogActivity { low, medium, high }

enum DogGastronomy { none, selective, gourmet }

// Dog breed data should be defined before saving it as draft. That's the first step

class DogProfile {
  final Breed? breed;

  final String? name;

  final DogSex? sex;
  final bool? sterilized;

  final int? birthMonth;
  final int? birthYear;

  final DogSize? size;
  final int? weight;

  final DogActivity? activity;

  final bool? hasIllness;

  final DogGastronomy? gastronomy;

  final Owner? owner;

  DogProfile({
    this.breed,
    this.name,
    this.sex,
    this.sterilized,
    this.birthMonth,
    this.birthYear,
    this.size,
    this.weight,
    this.activity,
    this.hasIllness,
    this.gastronomy,
    this.owner,
  });

  DogProfile copyWith({
    Breed? breed,
    String? name,
    DogSex? sex,
    bool? sterilized,
    int? birthMonth,
    int? birthYear,
    DogSize? size,
    int? weight,
    DogActivity? activity,
    bool? hasIllness,
    DogGastronomy? gastronomy,
    Owner? owner,
  }) {
    return DogProfile(
      breed: breed ?? this.breed,
      name: name ?? this.name,
      sex: sex ?? this.sex,
      sterilized: sterilized ?? this.sterilized,
      birthMonth: birthMonth ?? this.birthMonth,
      birthYear: birthYear ?? this.birthYear,
      size: size ?? this.size,
      weight: weight ?? this.weight,
      activity: activity ?? this.activity,
      hasIllness: hasIllness ?? this.hasIllness,
      gastronomy: gastronomy ?? this.gastronomy,
      owner: owner ?? this.owner,
    );
  }
}

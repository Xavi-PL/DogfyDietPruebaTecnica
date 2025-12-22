import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

enum DogSex { male, female }

enum DogSize { small, medium, big }

enum DogActivity { low, medium, high }

enum DogGastronomy { none, selective, gourmet }

// Dog breed data should be defined before saving it as draft. That's the first step

class DogProfile {
  final Breed breed;

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
    required this.breed,
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
}

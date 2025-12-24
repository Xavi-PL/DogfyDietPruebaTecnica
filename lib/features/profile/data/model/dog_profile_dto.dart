import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/breed_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/owner_dto.dart';

class DogProfileDto {
  final BreedDto? breed;
  final String? name;
  final String? sex;
  final bool? sterilized;
  final int? birthMonth;
  final int? birthYear;
  final String? size;
  final double? weight;
  final String? activity;
  final bool? hasIllness;
  final String? gastronomy;
  final OwnerDto? owner;

  const DogProfileDto({
    required this.breed,
    required this.name,
    required this.sex,
    required this.sterilized,
    required this.birthMonth,
    required this.birthYear,
    required this.size,
    required this.weight,
    required this.activity,
    required this.hasIllness,
    required this.gastronomy,
    required this.owner,
  });
}

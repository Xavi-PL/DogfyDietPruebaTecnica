import 'dart:convert';
import 'dart:math';

import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/mapper/breed_mapper.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:flutter/services.dart';

class DogProfileRemoteDataSourceImpl implements DogProfileRemoteDataSource {
  @override
  Future<List<Breed>> fetchDogBreeds() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // Use the mock JSON breeds.json
    final raw = await rootBundle.loadString('assets/mock/breeds.json');

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return [];
    }

    // Convert from Json to Breed
    final mapper = BreedMapper();
    final breedsDto = mapper.fromJsonList(decoded);
    final breeds = breedsDto.map((dto) => mapper.toDomain(dto)).toList();

    return breeds;
  }

  @override
  Future<bool> createDogProfile(DogProfile dogProfile) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Emulate request to the server. 80% success rate of success.
    return Random().nextInt(100) < 80;
  }
}

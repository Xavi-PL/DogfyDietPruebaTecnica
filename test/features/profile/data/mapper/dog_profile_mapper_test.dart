import 'package:dogfy_diet_prueba_tecnica/features/profile/data/mapper/dog_profile_mapper.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/breed_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/dog_profile_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/owner_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DogProfileMapper mapper;

  setUp(() {
    mapper = DogProfileMapper();
  });

  final tBreedDto = BreedDto(id: 1, name: 'Labrador');
  final tOwnerDto = OwnerDto(
    name: 'John',
    email: 'john@example.com',
    country: 'Spain',
    phone: '123456789',
    address: '123 St',
  );

  final tDogProfileDto = DogProfileDto(
    breed: tBreedDto,
    name: 'Buddy',
    sex: 'male',
    sterilized: true,
    birthMonth: 1,
    birthYear: 2020,
    size: 'medium',
    weight: '20',
    activity: 'high',
    hasIllness: false,
    gastronomy: 'gourmet',
    owner: tOwnerDto,
  );

  test('should map from DTO to Domain', () {
    final result = mapper.toDomain(tDogProfileDto);

    expect(result.breed?.id, 1);
    expect(result.breed?.name, 'Labrador');
    expect(result.name, 'Buddy');
    expect(result.sex, DogSex.male);
    expect(result.sterilized, true);
    expect(result.birthMonth, 1);
    expect(result.birthYear, 2020);
    expect(result.size, DogSize.medium);
    expect(result.weight, '20');
    expect(result.activity, DogActivity.high);
    expect(result.hasIllness, false);
    expect(result.gastronomy, DogGastronomy.gourmet);
    expect(result.owner?.name, 'John');
  });

  test('should map from Domain to DTO', () {
    final domain = mapper.toDomain(tDogProfileDto);
    final result = mapper.fromDomain(domain);

    expect(result.name, tDogProfileDto.name);
    expect(result.breed?.id, tDogProfileDto.breed?.id);
    expect(result.sex, tDogProfileDto.sex);
    expect(result.size, tDogProfileDto.size);
    // ... check other fields
  });

  test('should serialize to JSON and back', () {
    final json = mapper.toJson(tDogProfileDto);
    final result = mapper.fromJson(json);

    expect(result.name, tDogProfileDto.name);
    expect(result.breed?.id, tDogProfileDto.breed?.id);
  });
}

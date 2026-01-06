import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/repository/dog_profile_remote_repository_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDogProfileRemoteDataSource extends Mock
    implements DogProfileRemoteDataSource {}

class FakeDogProfile extends Fake implements DogProfile {}

void main() {
  late DogProfileRemoteRepositoryImpl repository;
  late MockDogProfileRemoteDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeDogProfile());
  });

  setUp(() {
    mockDataSource = MockDogProfileRemoteDataSource();
    repository = DogProfileRemoteRepositoryImpl(remote: mockDataSource);
  });

  group('fetchDogBreeds', () {
    test('should call datasource.fetchDogBreeds', () async {
      // Arrange
      final tBreeds = [const Breed(id: 1, name: 'Labrador')];
      when(
        () => mockDataSource.fetchDogBreeds(),
      ).thenAnswer((_) async => tBreeds);

      // Act
      final result = await repository.fetchDogBreeds();

      // Assert
      verify(() => mockDataSource.fetchDogBreeds()).called(1);
      expect(result, tBreeds);
    });
  });

  group('createDogProfile', () {
    test('should call datasource.createDogProfile', () async {
      // Arrange
      final tProfile = DogProfile(name: 'Buddy');
      when(
        () => mockDataSource.createDogProfile(any()),
      ).thenAnswer((_) async => true);

      // Act
      final result = await repository.createDogProfile(tProfile);

      // Assert
      verify(() => mockDataSource.createDogProfile(tProfile)).called(1);
      expect(result, true);
    });
  });
}

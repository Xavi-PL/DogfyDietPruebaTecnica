import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/repository/dog_profile_local_repository_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDogProfileLocalDataSource extends Mock
    implements DogProfileLocalDataSource {}

class FakeDogProfile extends Fake implements DogProfile {}

void main() {
  late DogProfileLocalRepositoryImpl repository;
  late MockDogProfileLocalDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeDogProfile());
  });

  setUp(() {
    mockDataSource = MockDogProfileLocalDataSource();
    repository = DogProfileLocalRepositoryImpl(local: mockDataSource);
  });

  group('saveDogProfileDraft', () {
    test('should call datasource.saveDogProfileDraft', () async {
      // Arrange
      final tProfile = DogProfile(name: 'Buddy');
      when(
        () => mockDataSource.saveDogProfileDraft(any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.saveDogProfileDraft(tProfile);

      // Assert
      verify(() => mockDataSource.saveDogProfileDraft(tProfile)).called(1);
    });
  });

  group('loadDogProfileDraft', () {
    test('should call datasource.loadDogProfileDraft', () async {
      // Arrange
      final tProfile = DogProfile(name: 'Buddy');
      when(
        () => mockDataSource.loadDogProfileDraft(),
      ).thenAnswer((_) async => tProfile);

      // Act
      final result = await repository.loadDogProfileDraft();

      // Assert
      verify(() => mockDataSource.loadDogProfileDraft()).called(1);
      expect(result, tProfile);
    });
  });

  group('clearDogProfileDraft', () {
    test('should call datasource.clearDogProfileDraft', () async {
      // Arrange
      when(
        () => mockDataSource.clearDogProfileDraft(),
      ).thenAnswer((_) async {});

      // Act
      await repository.clearDogProfileDraft();

      // Assert
      verify(() => mockDataSource.clearDogProfileDraft()).called(1);
    });
  });

  group('hasDogProfileDraft', () {
    test('should call datasource.hasDogProfileDraft', () async {
      // Arrange
      when(
        () => mockDataSource.hasDogProfileDraft(),
      ).thenAnswer((_) async => true);

      // Act
      final result = await repository.hasDogProfileDraft();

      // Assert
      verify(() => mockDataSource.hasDogProfileDraft()).called(1);
      expect(result, true);
    });
  });
}

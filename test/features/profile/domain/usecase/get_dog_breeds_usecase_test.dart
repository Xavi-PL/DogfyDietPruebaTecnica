import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/get_dog_breeds.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';

class MockDogProfileRemoteRepository extends Mock
    implements DogProfileRemoteRepository {}

void main() {
  late GetDogBreedsUseCase useCase;
  late MockDogProfileRemoteRepository mockRepository;

  setUp(() {
    mockRepository = MockDogProfileRemoteRepository();
    useCase = GetDogBreedsUseCase(mockRepository);
  });

  test('should return list of breeds from repository', () async {
    final breeds = [
      Breed(id: 1, name: 'Labrador'),
      Breed(id: 2, name: 'Poodle'),
    ];

    when(() => mockRepository.fetchDogBreeds()).thenAnswer((_) async => breeds);

    final result = await useCase();

    expect(result, breeds);
    verify(() => mockRepository.fetchDogBreeds()).called(1);
  });
}

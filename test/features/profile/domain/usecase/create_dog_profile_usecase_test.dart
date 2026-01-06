import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/create_dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

class MockDogProfileRemoteRepository extends Mock
    implements DogProfileRemoteRepository {}

class FakeDogProfile extends Fake implements DogProfile {}

void main() {
  late CreateDogProfileUseCase useCase;
  late MockDogProfileRemoteRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeDogProfile());
  });

  setUp(() {
    mockRepository = MockDogProfileRemoteRepository();
    useCase = CreateDogProfileUseCase(mockRepository);
  });

  test(
    'should call createDogProfile on repository and return result',
    () async {
      final dogProfile = DogProfile(name: 'Buddy', owner: Owner());

      when(
        () => mockRepository.createDogProfile(any()),
      ).thenAnswer((_) async => true);

      final result = await useCase(dogProfile);

      expect(result, true);
      verify(() => mockRepository.createDogProfile(dogProfile)).called(1);
    },
  );
}

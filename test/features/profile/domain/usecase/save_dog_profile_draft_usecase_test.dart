import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/save_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class MockDogProfileLocalRepository extends Mock
    implements DogProfileLocalRepository {}

class FakeDogProfile extends Fake implements DogProfile {}

void main() {
  late SaveDogProfileDraftUseCase useCase;
  late MockDogProfileLocalRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeDogProfile());
  });

  setUp(() {
    mockRepository = MockDogProfileLocalRepository();
    useCase = SaveDogProfileDraftUseCase(mockRepository);
  });

  test('should call saveDogProfileDraft on repository', () async {
    final dogProfile = DogProfile(name: 'Buddy');

    when(
      () => mockRepository.saveDogProfileDraft(any()),
    ).thenAnswer((_) async {});

    await useCase(dogProfile);

    verify(() => mockRepository.saveDogProfileDraft(dogProfile)).called(1);
  });
}

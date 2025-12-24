import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';

class SaveDogProfileDraftUseCase {
  final DogProfileLocalRepository repository;

  SaveDogProfileDraftUseCase(this.repository);

  Future<void> call(DogProfile dogProfile) async {
    await repository.saveDogProfileDraft(dogProfile);
  }
}

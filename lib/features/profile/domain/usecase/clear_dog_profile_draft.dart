import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';

class ClearDogProfileDraftUseCase {
  final DogProfileLocalRepository repository;

  ClearDogProfileDraftUseCase(this.repository);

  Future<void> call() async {
    return repository.clearDogProfileDraft();
  }
}

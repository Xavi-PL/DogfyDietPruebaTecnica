import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';

class HasDogProfileDraftUseCase {
  final DogProfileLocalRepository repository;

  HasDogProfileDraftUseCase(this.repository);

  Future<bool> call() {
    return repository.hasDogProfileDraft();
  }
}

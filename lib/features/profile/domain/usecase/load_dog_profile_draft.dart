import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';

class LoadDogProfileDraftUseCase {
  final DogProfileLocalRepository repository;

  LoadDogProfileDraftUseCase(this.repository);

  Future<DogProfile> call() async {
    return repository.loadDogProfileDraft();
  }
}

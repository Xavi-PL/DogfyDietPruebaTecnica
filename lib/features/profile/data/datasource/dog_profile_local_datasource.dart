import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

abstract interface class DogProfileLocalDataSource {
  Future<void> clearDogProfileDraft();

  Future<DogProfile> loadDogProfileDraft();

  Future<void> saveDogProfileDraft(DogProfile dogProfile);

  Future<bool> hasDogProfileDraft();
}

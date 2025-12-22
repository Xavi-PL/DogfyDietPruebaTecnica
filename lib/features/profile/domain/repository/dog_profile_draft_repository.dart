import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

/// Repository for all tasks related to dog profile drafts.
abstract interface class DogProfileDraftRepository {
  /// Saves the dog profile draft.
  Future<void> saveDogProfileDraft(DogProfile dogProfile);

  /// Loads the dog profile draft.
  Future<DogProfile> loadDogProfileDraft();

  /// Clears the dog profile draft.
  Future<void> clearDogProfileDraft();
}

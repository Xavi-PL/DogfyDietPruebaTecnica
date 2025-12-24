import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

/// Repository for all tasks related to dog profiles.
abstract interface class DogProfileRemoteRepository {
  /// Fetches the list of breeds.
  Future<List<Breed>> fetchDogBreeds();

  /// Creates a new dog profile.
  Future<void> createDogProfile(DogProfile dogProfile);
}

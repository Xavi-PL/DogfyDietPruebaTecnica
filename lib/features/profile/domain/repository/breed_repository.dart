import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';

/// Repository for all tasks related to breeds.
abstract interface class BreedRepository {
  /// Fetches the list of breeds.
  Future<List<Breed>> fetchDogBreeds();
}

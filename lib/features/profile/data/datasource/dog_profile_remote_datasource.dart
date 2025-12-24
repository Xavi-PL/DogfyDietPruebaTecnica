import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

abstract class DogProfileRemoteDataSource {
  Future<void> createDogProfile(DogProfile dogProfile);
  Future<List<Breed>> fetchDogBreeds();
}

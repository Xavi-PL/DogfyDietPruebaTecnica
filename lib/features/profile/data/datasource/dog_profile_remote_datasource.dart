import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

abstract class DogProfileRemoteDataSource {
  Future<List<Breed>> fetchDogBreeds();
  Future<bool> createDogProfile(DogProfile dogProfile);
}

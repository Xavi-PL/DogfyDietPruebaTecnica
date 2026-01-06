import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';

class GetDogBreedsUseCase {
  final DogProfileRemoteRepository remote;

  GetDogBreedsUseCase(this.remote);

  Future<List<Breed>> call() async {
    return remote.fetchDogBreeds();
  }
}

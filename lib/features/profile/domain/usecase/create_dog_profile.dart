import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';

class CreateDogProfileUseCase {
  final DogProfileRemoteRepository remote;

  CreateDogProfileUseCase(this.remote);

  Future<bool> call(DogProfile dogProfile) async {
    return remote.createDogProfile(dogProfile);
  }
}

import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';

class DogProfileRemoteRepositoryImpl implements DogProfileRemoteRepository {
  final DogProfileRemoteDataSource remote;

  DogProfileRemoteRepositoryImpl({required this.remote});

  @override
  Future<List<Breed>> fetchDogBreeds() {
    return remote.fetchDogBreeds();
  }

  @override
  Future<bool> createDogProfile(DogProfile dogProfile) {
    return remote.createDogProfile(dogProfile);
  }
}

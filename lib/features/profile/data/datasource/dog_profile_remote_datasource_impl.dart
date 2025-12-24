import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class DogProfileRemoteDataSourceImpl implements DogProfileRemoteDataSource {
  @override
  Future<void> createDogProfile(DogProfile dogProfile) {
    throw UnimplementedError();
  }

  @override
  Future<List<Breed>> fetchDogBreeds() {
    throw UnimplementedError();
  }
}

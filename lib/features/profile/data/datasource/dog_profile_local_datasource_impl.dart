import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class DogProfileLocalDataSourceImpl implements DogProfileLocalDataSource {
  @override
  Future<void> clearDogProfileDraft() {
    throw UnimplementedError();
  }

  @override
  Future<DogProfile> loadDogProfileDraft() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveDogProfileDraft(DogProfile dogProfile) {
    throw UnimplementedError();
  }
}

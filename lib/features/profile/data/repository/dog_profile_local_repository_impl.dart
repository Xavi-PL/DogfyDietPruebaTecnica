import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';

class DogProfileLocalRepositoryImpl implements DogProfileLocalRepository {
  final DogProfileLocalDataSource local;

  DogProfileLocalRepositoryImpl({required this.local});

  @override
  Future<void> clearDogProfileDraft() async {
    return local.clearDogProfileDraft();
  }

  @override
  Future<DogProfile?> loadDogProfileDraft() async {
    return local.loadDogProfileDraft();
  }

  @override
  Future<void> saveDogProfileDraft(DogProfile dogProfile) async {
    return local.saveDogProfileDraft(dogProfile);
  }
}

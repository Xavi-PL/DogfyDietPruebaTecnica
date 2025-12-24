import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/repository/dog_profile_local_repository_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/repository/dog_profile_remote_repository_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_local_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/repository/dog_profile_remote_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/clear_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/load_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/save_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerDogProfileModule() {
  getIt.registerLazySingleton<DogProfileLocalDataSource>(
    () => DogProfileLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<DogProfileRemoteDataSource>(
    () => DogProfileRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<DogProfileLocalRepository>(
    () => DogProfileLocalRepositoryImpl(local: getIt()),
  );

  getIt.registerLazySingleton<DogProfileRemoteRepository>(
    () => DogProfileRemoteRepositoryImpl(remote: getIt()),
  );

  getIt.registerFactory(() => SaveDogProfileDraftUseCase(getIt()));
  getIt.registerFactory(() => LoadDogProfileDraftUseCase(getIt()));
  getIt.registerFactory(() => ClearDogProfileDraftUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => DogProfileBloc(
      saveDogProfileDraft: getIt(),
      loadDogProfileDraft: getIt(),
      clearDogProfileDraft: getIt(),
      getCurrentAddress: getIt(),
    ),
  );
}

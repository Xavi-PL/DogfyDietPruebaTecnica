import 'package:dogfy_diet_prueba_tecnica/core/platform/location/data/datasource/location_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/data/datasource/location_datasource_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/data/repository/location_repository_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/repository/location_repository.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/usecase/get_current_address.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerLocationModule() {
  getIt.registerLazySingleton<LocationDatasource>(
    () => LocationDatasourceImpl(),
  );

  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => GetCurrentAddress(getIt()));
}

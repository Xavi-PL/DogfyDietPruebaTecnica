import 'package:dogfy_diet_prueba_tecnica/core/platform/location/data/datasource/location_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource locationDatasource;

  LocationRepositoryImpl(this.locationDatasource);

  @override
  Future<String> getCurrentAddress() {
    return locationDatasource.getCurrentAddress();
  }
}

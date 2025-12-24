import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/repository/location_repository.dart';

class GetCurrentAddress {
  final LocationRepository locationRepository;

  GetCurrentAddress(this.locationRepository);

  Future<String?> call() async {
    return locationRepository.getCurrentAddress();
  }
}

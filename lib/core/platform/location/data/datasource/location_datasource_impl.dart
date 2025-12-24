import 'package:dogfy_diet_prueba_tecnica/core/platform/location/data/datasource/location_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/error/location_exception.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationDatasourceImpl implements LocationDatasource {
  @override
  Future<String> getCurrentAddress() async {
    // Check first if location is enabled on the device.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServicesDisabled();
    }

    // Check if the app has permission to access location.
    final permission = await Geolocator.checkPermission();

    // If this is the first time location is asked, the permission can be asked again.
    // If not, dialog shouldn't appear and permission will be denied always.
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result == LocationPermission.denied) {
        throw LocationPermissionDenied();
      } else if (result == LocationPermission.deniedForever) {
        throw LocationPermissionDeniedForever();
      }
    }

    // Obtain the current position.
    final position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );

    // Get the address from the position using Geocoding library.
    final placemarks = await GeocodingPlatform.instance
        ?.placemarkFromCoordinates(position.latitude, position.longitude);

    // If null or it's empty throw LocationNotFound
    if (placemarks?.isEmpty ?? true) {
      throw LocationNotFound();
    }

    // Parse the address into a readable string.
    final p = placemarks?.first;
    final street = <String?>[
      p?.street,
      p?.subLocality,
      p?.locality,
      p?.postalCode,
      p?.administrativeArea,
      p?.country,
    ].where((e) => e != null && e.trim().isNotEmpty).toList();

    return street.join(', ');
  }
}

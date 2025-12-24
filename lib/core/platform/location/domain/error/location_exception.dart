sealed class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationPermissionDenied extends LocationException {
  const LocationPermissionDenied() : super('Location permission denied');
}

class LocationServicesDisabled extends LocationException {
  const LocationServicesDisabled() : super('Location services are disabled');
}

class LocationNotFound extends LocationException {
  const LocationNotFound() : super('Unable to resolve address');
}

import 'package:dogfy_diet_prueba_tecnica/core/platform/location/di/location_module.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/di/profile_module.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  await _initializeHive();
  initializeDateFormatting();
  registerLocationModule();
  registerDogProfileModule();
}

Future<void> _initializeHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

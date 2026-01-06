import 'package:dogfy_diet_prueba_tecnica/core/di/injection.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffffd44a)),
      ),
      home: DogProfileWizardScreen(),
    );
  }
}

import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: DogProfileWizardScreen(),
    );
  }
}

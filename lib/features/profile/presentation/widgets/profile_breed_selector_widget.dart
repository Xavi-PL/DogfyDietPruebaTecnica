import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:flutter/material.dart';

class ProfileBreedSelectorWidget extends StatelessWidget {
  final List<Breed> availableBreeds;
  final Function(Breed) onBreedSelected;
  const ProfileBreedSelectorWidget({
    super.key,
    required this.availableBreeds,
    required this.onBreedSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: DropdownMenu(
        hintText: "Selecciona una raza",
        width: double.infinity,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),

        alignmentOffset: const Offset(0, 8),
        menuStyle: MenuStyle(
          elevation: WidgetStatePropertyAll(5),
          alignment: Alignment.bottomLeft, // forces menu below
        ),
        dropdownMenuEntries: availableBreeds
            .map((breed) => DropdownMenuEntry(value: breed, label: breed.name))
            .toList(),
        onSelected: (breed) => onBreedSelected(breed!),
      ),
    );
  }
}

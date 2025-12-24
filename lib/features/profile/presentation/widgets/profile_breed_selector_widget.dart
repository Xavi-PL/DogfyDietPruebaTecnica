import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:flutter/material.dart';

class ProfileBreedSelectorWidget extends StatelessWidget {
  final List<Breed> availableBreeds;
  final Function(Breed) onBreedSelected;
  final Breed? selectedBreed;
  const ProfileBreedSelectorWidget({
    super.key,
    required this.availableBreeds,
    required this.onBreedSelected,
    this.selectedBreed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Breed>(
        isExpanded: true,
        underline: const SizedBox(),
        value: selectedBreed,
        hint: const Text('Selecciona una raza'),
        menuMaxHeight: 200,
        items: availableBreeds.map((breed) {
          return DropdownMenuItem(value: breed, child: Text(breed.name));
        }).toList(),
        onChanged: (breed) {
          if (breed != null) {
            onBreedSelected(breed);
          }
        },
      ),
    );
  }
}

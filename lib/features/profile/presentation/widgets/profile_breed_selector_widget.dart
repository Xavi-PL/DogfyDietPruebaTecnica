import 'package:flutter/material.dart';

class ProfileBreedSelectorWidget extends StatelessWidget {
  final List<String> availableBreeds;
  final Function(String) onBreedSelected;
  final String? selectedBreed;
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
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: selectedBreed,
        hint: const Text('Selecciona una raza'),
        menuMaxHeight: 200,
        items: availableBreeds.map((breed) {
          return DropdownMenuItem(value: breed, child: Text(breed));
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

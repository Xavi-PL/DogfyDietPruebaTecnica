import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class DogProfileState {
  final int currentStep;
  final List<Breed> availableBreeds;
  final DogProfile? dogProfile;

  DogProfileState({
    required this.currentStep,
    this.availableBreeds = const [],
    this.dogProfile,
  });

  factory DogProfileState.initial() => DogProfileState(
    currentStep: 0,
    availableBreeds: const [
      Breed(name: 'Labrador', id: 1),
      Breed(name: 'Golden Retriever', id: 2),
      Breed(name: 'Breed 3', id: 3),
      Breed(name: 'Breed 4', id: 4),
      Breed(name: 'Breed 5', id: 5),
      Breed(name: 'Breed 6', id: 6),
      Breed(name: 'Breed 7', id: 7),
      Breed(name: 'Breed 8', id: 8),
      Breed(name: 'Breed 9', id: 9),
      Breed(name: 'Breed 10', id: 10),
    ],
  );

  DogProfileState copyWith({
    int? currentStep,
    DogProfile? dogProfile,
    List<Breed>? availableBreeds,
  }) {
    return DogProfileState(
      currentStep: currentStep ?? this.currentStep,
      dogProfile: dogProfile ?? this.dogProfile,
      availableBreeds: availableBreeds ?? this.availableBreeds,
    );
  }

  bool isStepValid() {
    switch (currentStep) {
      case 0:
        return dogProfile?.breed != null;
      case 1:
        return dogProfile?.name != null;
      default:
        return false;
    }
  }
}

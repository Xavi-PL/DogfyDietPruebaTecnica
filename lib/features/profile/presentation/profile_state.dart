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

  factory DogProfileState.initial() =>
      DogProfileState(currentStep: 0, availableBreeds: const []);

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
}

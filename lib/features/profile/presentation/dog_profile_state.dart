import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';

class DogProfileState {
  final int currentStep;
  final DogProfile? dogProfile;

  DogProfileState({required this.currentStep, this.dogProfile});

  factory DogProfileState.initial() => DogProfileState(currentStep: 0);

  DogProfileState copyWith({int? currentStep, DogProfile? dogProfile}) {
    return DogProfileState(
      currentStep: currentStep ?? this.currentStep,
      dogProfile: dogProfile ?? this.dogProfile,
    );
  }
}

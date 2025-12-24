import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

class DogProfileState {
  final int currentStep;
  final bool ready;

  final List<Breed> availableBreeds;
  final DogProfile? dogProfile;
  final bool moreThanOneDog;
  final bool isLoadingAddress;
  final bool isCreatingDogProfile;

  DogProfileState({
    required this.currentStep,
    this.ready = false,
    this.availableBreeds = const [],
    this.moreThanOneDog = false,
    this.dogProfile,
    this.isLoadingAddress = false,
    this.isCreatingDogProfile = false,
  });

  factory DogProfileState.initial() => DogProfileState(
    dogProfile: DogProfile(owner: Owner()),
    currentStep: 0,
    availableBreeds: const [],
    ready: false,
  );

  DogProfileState copyWith({
    int? currentStep,
    bool? ready,
    DogProfile? dogProfile,
    List<Breed>? availableBreeds,
    bool? moreThanOneDog,
    bool? isLoadingAddress,
    bool? isCreatingDogProfile,
  }) {
    return DogProfileState(
      currentStep: currentStep ?? this.currentStep,
      dogProfile: dogProfile ?? this.dogProfile,
      availableBreeds: availableBreeds ?? this.availableBreeds,
      moreThanOneDog: moreThanOneDog ?? this.moreThanOneDog,
      isLoadingAddress: isLoadingAddress ?? this.isLoadingAddress,
      isCreatingDogProfile: isCreatingDogProfile ?? this.isCreatingDogProfile,
      ready: ready ?? this.ready,
    );
  }

  bool isStepValid() {
    switch (currentStep) {
      case 0:
        return dogProfile?.breed != null;
      case 1:
        return dogProfile?.name != null;
      case 2:
        return dogProfile?.sex != null && dogProfile?.sterilized != null;
      case 3:
        return dogProfile?.birthMonth != null && dogProfile?.birthYear != null;
      case 4:
        return dogProfile?.size != null && dogProfile?.weight != null;
      case 5:
        return dogProfile?.activity != null;
      case 6:
        return dogProfile?.hasIllness != null;
      case 7:
        return dogProfile?.gastronomy != null;
      case 8:
        return dogProfile?.owner!.name != null &&
            dogProfile?.owner!.email != null &&
            dogProfile?.owner!.country != null &&
            dogProfile?.owner!.phone != null &&
            dogProfile?.owner!.address != null;
      default:
        return false;
    }
  }
}

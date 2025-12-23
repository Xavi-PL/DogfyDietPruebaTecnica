import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

sealed class DogProfileEvent {}

// Setting the breed is the first step of the form. Mandatory before saving a draft of a profile.
class BreedSelected extends DogProfileEvent {
  final Breed breed;
  BreedSelected({required this.breed});
}

// Second step of the form.
class DogNameSet extends DogProfileEvent {
  final String dogName;
  DogNameSet({required this.dogName});
}

// Third step of the form.
class DogSexAndSterilizedSet extends DogProfileEvent {
  final DogSex sex;
  final bool sterilized;
  DogSexAndSterilizedSet({required this.sex, required this.sterilized});
}

// Fourth step of the form.
class DogBirthDateSelected extends DogProfileEvent {
  final int birthMonth;
  final int birthYear;
  DogBirthDateSelected({required this.birthMonth, required this.birthYear});
}

// Fifth step of the form.
class DogSizeAndWeightSet extends DogProfileEvent {
  final DogSize size;
  final int weight;
  DogSizeAndWeightSet({required this.size, required this.weight});
}

// Sixth step of the form.
class DogActivitySet extends DogProfileEvent {
  final DogActivity activity;
  DogActivitySet({required this.activity});
}

// Seventh step of the form.
class DogHasIllnessSet extends DogProfileEvent {
  final bool hasIllness;
  DogHasIllnessSet({required this.hasIllness});
}

// Eighth step of the form.
class DogGastronomySet extends DogProfileEvent {
  final DogGastronomy gastronomy;
  DogGastronomySet({required this.gastronomy});
}

// Last step of the form.
class DogOwnerSet extends DogProfileEvent {
  final Owner owner;
  DogOwnerSet({required this.owner});
}

class NextStep extends DogProfileEvent {}

class PreviousStep extends DogProfileEvent {}

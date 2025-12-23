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

class MoreThanOneDogTapped extends DogProfileEvent {}

// Third step of the form.
class DogSexSet extends DogProfileEvent {
  final DogSex sex;
  DogSexSet({required this.sex});
}

// Also from third step of the form.
class DogSterilizedSet extends DogProfileEvent {
  final bool sterilized;
  DogSterilizedSet({required this.sterilized});
}

// Fourth step of the form.
class DogBirthMonthSelected extends DogProfileEvent {
  final int month;
  DogBirthMonthSelected({required this.month});
}

// Also from fourth step of the form.
class DogBirthYearSelected extends DogProfileEvent {
  final int year;
  DogBirthYearSelected({required this.year});
}

// Fifth step of the form.
class DogSizeSet extends DogProfileEvent {
  final DogSize size;
  DogSizeSet({required this.size});
}

// Also from fifth step of the form.
class DogWeightSet extends DogProfileEvent {
  final double weight;
  DogWeightSet({required this.weight});
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

import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileBloc extends Bloc<DogProfileEvent, DogProfileState> {
  DogProfileBloc() : super(DogProfileState.initial()) {
    on<BreedSelected>(onBreedSelected);
    on<DogNameSet>(onDogNameSet);
    on<MoreThanOneDogTapped>(onMoreThanOneDogTapped);
    on<DogSexAndSterilizedSet>(onDogSexAndSterilizedSet);
    on<DogBirthDateSelected>(onDogBirthDateSelected);
    on<DogSizeAndWeightSet>(onDogSizeAndWeightSet);
    on<DogActivitySet>(onDogActivitySet);
    on<DogHasIllnessSet>(onDogHasIllnessSet);
    on<DogGastronomySet>(onDogGastronomySet);
    on<DogOwnerSet>(onDogOwnerSet);
    on<NextStep>(onNextStep);
    on<PreviousStep>(onPreviousStep);
  }

  void onBreedSelected(BreedSelected event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(dogProfile: DogProfile(breed: event.breed)));
  }

  void onDogNameSet(DogNameSet event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(dogProfile: DogProfile(name: event.dogName)));
  }

  void onMoreThanOneDogTapped(
    MoreThanOneDogTapped event,
    Emitter<DogProfileState> emit,
  ) {
    emit(state.copyWith(moreThanOneDog: true));
  }

  void onDogSexAndSterilizedSet(
    DogSexAndSterilizedSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: DogProfile(sex: event.sex, sterilized: event.sterilized),
      ),
    );
  }

  void onDogBirthDateSelected(
    DogBirthDateSelected event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: DogProfile(
          birthMonth: event.birthMonth,
          birthYear: event.birthYear,
        ),
      ),
    );
  }

  void onDogSizeAndWeightSet(
    DogSizeAndWeightSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: DogProfile(size: event.size, weight: event.weight),
      ),
    );
  }

  void onDogActivitySet(DogActivitySet event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(dogProfile: DogProfile(activity: event.activity)));
  }

  void onDogHasIllnessSet(
    DogHasIllnessSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(state.copyWith(dogProfile: DogProfile(hasIllness: event.hasIllness)));
  }

  void onDogGastronomySet(
    DogGastronomySet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(state.copyWith(dogProfile: DogProfile(gastronomy: event.gastronomy)));
  }

  void onDogOwnerSet(DogOwnerSet event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(dogProfile: DogProfile(owner: event.owner)));
  }

  void onNextStep(NextStep event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void onPreviousStep(PreviousStep event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }
}

import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileBloc extends Bloc<DogProfileEvent, DogProfileState> {
  DogProfileBloc() : super(DogProfileState.initial()) {
    on<BreedSelected>(onBreedSelected);
    on<DogNameSet>(onDogNameSet);
    on<MoreThanOneDogTapped>(onMoreThanOneDogTapped);
    on<DogSexSet>(onDogSexSet);
    on<DogSterilizedSet>(onDogSterilizedSet);
    on<DogBirthMonthSelected>(onDogBirthMonthSelected);
    on<DogBirthYearSelected>(onDogBirthYearSelected);
    on<DogSizeSet>(onDogSizeSet);
    on<DogWeightSet>(onDogWeightSet);
    on<DogActivitySet>(onDogActivitySet);
    on<DogHasIllnessSet>(onDogHasIllnessSet);
    on<DogGastronomySet>(onDogGastronomySet);
    on<DogOwnerNameSet>(onDogOwnerNameSet);
    on<DogOwnerCountrySet>(onDogOwnerCountrySet);
    on<DogOwnerPhoneSet>(onDogOwnerPhoneSet);
    on<DogOwnerEmailSet>(onDogOwnerEmailSet);
    on<DogOwnerAddressSet>(onDogOwnerAddressSet);
    on<NextStep>(onNextStep);
    on<PreviousStep>(onPreviousStep);
  }

  void onBreedSelected(BreedSelected event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(breed: event.breed),
      ),
    );
  }

  void onDogNameSet(DogNameSet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(name: event.dogName),
      ),
    );
  }

  void onMoreThanOneDogTapped(
    MoreThanOneDogTapped event,
    Emitter<DogProfileState> emit,
  ) {
    emit(state.copyWith(moreThanOneDog: true));
  }

  void onDogSexSet(DogSexSet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(dogProfile: state.dogProfile?.copyWith(sex: event.sex)),
    );
  }

  void onDogSterilizedSet(
    DogSterilizedSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(sterilized: event.sterilized),
      ),
    );
  }

  void onDogBirthMonthSelected(
    DogBirthMonthSelected event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(birthMonth: event.month),
      ),
    );
  }

  void onDogBirthYearSelected(
    DogBirthYearSelected event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(birthYear: event.year),
      ),
    );
  }

  void onDogSizeSet(DogSizeSet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(dogProfile: state.dogProfile?.copyWith(size: event.size)),
    );
  }

  void onDogWeightSet(DogWeightSet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(weight: event.weight),
      ),
    );
  }

  void onDogActivitySet(DogActivitySet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(activity: event.activity),
      ),
    );
  }

  void onDogHasIllnessSet(
    DogHasIllnessSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(hasIllness: event.hasIllness),
      ),
    );
  }

  void onDogGastronomySet(
    DogGastronomySet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(gastronomy: event.gastronomy),
      ),
    );
  }

  void onDogOwnerNameSet(DogOwnerNameSet event, Emitter<DogProfileState> emit) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(
          owner: state.dogProfile?.owner?.copyWith(name: event.ownerName),
        ),
      ),
    );
  }

  void onDogOwnerCountrySet(
    DogOwnerCountrySet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(
          owner: state.dogProfile?.owner?.copyWith(country: event.ownerCountry),
        ),
      ),
    );
  }

  void onDogOwnerPhoneSet(
    DogOwnerPhoneSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(
          owner: state.dogProfile?.owner?.copyWith(phone: event.ownerPhone),
        ),
      ),
    );
  }

  void onDogOwnerEmailSet(
    DogOwnerEmailSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(
          owner: state.dogProfile?.owner?.copyWith(email: event.ownerEmail),
        ),
      ),
    );
  }

  void onDogOwnerAddressSet(
    DogOwnerAddressSet event,
    Emitter<DogProfileState> emit,
  ) {
    emit(
      state.copyWith(
        dogProfile: state.dogProfile?.copyWith(
          owner: state.dogProfile?.owner?.copyWith(address: event.ownerAddress),
        ),
      ),
    );
  }

  void onNextStep(NextStep event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void onPreviousStep(PreviousStep event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }
}

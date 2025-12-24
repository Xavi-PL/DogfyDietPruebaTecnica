import 'package:alert_info/alert_info.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/usecase/get_current_address.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/clear_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/load_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/save_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileBloc extends Bloc<DogProfileEvent, DogProfileState> {
  final SaveDogProfileDraftUseCase saveDogProfileDraft;
  final LoadDogProfileDraftUseCase loadDogProfileDraft;
  final ClearDogProfileDraftUseCase clearDogProfileDraft;
  final GetCurrentAddress getCurrentAddress;

  DogProfileBloc({
    required this.saveDogProfileDraft,
    required this.loadDogProfileDraft,
    required this.clearDogProfileDraft,
    required this.getCurrentAddress,
  }) : super(DogProfileState.initial()) {
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
    on<SaveDraftRequested>(onSaveDraftRequested);
    on<GetAddressEvent>(onGetAddressEvent);
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

  Future<void> onSaveDraftRequested(
    SaveDraftRequested event,
    Emitter<DogProfileState> emit,
  ) async {
    await saveDogProfileDraft(event.dogProfile);
  }

  void onPreviousStep(PreviousStep event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void onGetAddressEvent(
    GetAddressEvent event,
    Emitter<DogProfileState> emit,
  ) async {
    emit(state.copyWith(isLoadingAddress: true));
    await getCurrentAddress()
        .then((value) {
          add(DogOwnerAddressSet(ownerAddress: value!));
        })
        .onError((error, stackTrace) {
          print(error);
        });
    emit(state.copyWith(isLoadingAddress: false));
  }
}

import 'dart:async';

import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/error/location_exception.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/usecase/get_current_address.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/clear_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/create_dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/get_dog_breeds.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/has_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/load_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/save_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileBloc extends Bloc<DogProfileEvent, DogProfileState> {
  final SaveDogProfileDraftUseCase saveDogProfileDraft;
  final LoadDogProfileDraftUseCase loadDogProfileDraft;
  final ClearDogProfileDraftUseCase clearDogProfileDraft;
  final GetCurrentAddress getCurrentAddress;
  final CreateDogProfileUseCase createDogProfile;
  final GetDogBreedsUseCase getDogBreeds;
  final HasDogProfileDraftUseCase hasDogProfileDraft;

  DogProfileBloc({
    required this.saveDogProfileDraft,
    required this.loadDogProfileDraft,
    required this.clearDogProfileDraft,
    required this.getCurrentAddress,
    required this.createDogProfile,
    required this.getDogBreeds,
    required this.hasDogProfileDraft,
  }) : super(DogProfileState.initial()) {
    on<ProfileStarted>(onProfileStarted);
    on<ProfileReady>(onProfileReady);
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
    on<CreateDogProfileRequested>(onCreateDogProfileRequested);
    on<ClearErrorMessage>(onClearErrorMessage);
    on<ProfileFinished>(onProfileFinished);
    on<NewProfile>(onNewProfile);

    // Execute the profile started event when the bloc is initialized.
    add(ProfileStarted());
  }

  void onProfileStarted(
    ProfileStarted event,
    Emitter<DogProfileState> emit,
  ) async {
    final breeds = await getDogBreeds.call();
    emit(state.copyWith(availableBreeds: breeds));

    // Check if there's a profile draft saved.
    final hasDraft = await hasDogProfileDraft();
    if (!hasDraft) {
      add(ProfileReady());
      return;
    }

    // Load the draft.
    final cached = await loadDogProfileDraft();

    // Compute which step to open based on cached data.
    final step = _computeStepFromProfile(cached);

    add(ProfileReady());
    emit(state.copyWith(dogProfile: cached, currentStep: step));
  }

  int _computeStepFromProfile(DogProfile profile) {
    bool step0() => profile.breed != null;
    bool step1() => profile.name != null;
    bool step2() => profile.sex != null && profile.sterilized != null;
    bool step3() => profile.birthMonth != null && profile.birthYear != null;
    bool step4() => profile.size != null && profile.weight != null;
    bool step5() => profile.activity != null;
    bool step6() => profile.hasIllness != null;
    bool step7() => profile.gastronomy != null;
    bool step8() => profile.owner != null;

    final stepChecks = <bool Function()>[
      step0,
      step1,
      step2,
      step3,
      step4,
      step5,
      step6,
      step7,
      step8,
    ];

    for (var i = 0; i < stepChecks.length; i++) {
      if (!stepChecks[i]()) return i;
    }
    // If every step is valid the user is at the last step (even that is impossible to reach here)
    return stepChecks.length - 1;
  }

  void onProfileReady(ProfileReady event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(ready: true));
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
    add(SaveDraftRequested(dogProfile: state.dogProfile!));
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
          if (error is LocationPermissionDeniedForever) {
            emit(
              state.copyWith(
                errorMessage:
                    'Para continuar, debes permitir el acceso a la ubicación desde la configuración de la app.',
              ),
            );
          } else if (error is LocationPermissionDenied) {
            emit(
              state.copyWith(
                errorMessage:
                    'Debes permitir el acceso a la ubicación para obtener tu dirección automáticamente.',
              ),
            );
          } else if (error is LocationServicesDisabled) {
            emit(
              state.copyWith(
                errorMessage:
                    'Para continuar, debes activar los servicios de ubicación del dispositivo.',
              ),
            );
          } else {
            emit(state.copyWith(errorMessage: error.toString()));
          }
        });
    emit(state.copyWith(isLoadingAddress: false));
  }

  Future<void> onCreateDogProfileRequested(
    CreateDogProfileRequested event,
    Emitter<DogProfileState> emit,
  ) async {
    emit(state.copyWith(isCreatingDogProfile: true));
    await createDogProfile(event.dogProfile)
        .then((value) {
          if (value) {
            add(ProfileFinished());
          }
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(errorMessage: error.toString()));
        });
    emit(state.copyWith(isCreatingDogProfile: false));
  }

  void onClearErrorMessage(
    ClearErrorMessage event,
    Emitter<DogProfileState> emit,
  ) {
    emit(state.copyWith(errorMessage: ''));
  }

  void onProfileFinished(ProfileFinished event, Emitter<DogProfileState> emit) {
    emit(state.copyWith(finished: true));
  }

  void onNewProfile(NewProfile event, Emitter<DogProfileState> emit) async {
    await clearDogProfileDraft();
    emit(
      state.copyWith(
        currentStep: 0,
        dogProfile: DogProfile(owner: Owner()),
        finished: false,
      ),
    );
  }
}

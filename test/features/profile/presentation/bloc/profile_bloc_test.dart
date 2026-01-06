import 'package:bloc_test/bloc_test.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/error/location_exception.dart';
import 'package:dogfy_diet_prueba_tecnica/core/platform/location/domain/usecase/get_current_address.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/clear_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/create_dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/get_dog_breeds.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/has_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/load_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/usecase/save_dog_profile_draft.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveDogProfileDraftUseCase extends Mock
    implements SaveDogProfileDraftUseCase {}

class MockLoadDogProfileDraftUseCase extends Mock
    implements LoadDogProfileDraftUseCase {}

class MockClearDogProfileDraftUseCase extends Mock
    implements ClearDogProfileDraftUseCase {}

class MockGetCurrentAddress extends Mock implements GetCurrentAddress {}

class MockCreateDogProfileUseCase extends Mock
    implements CreateDogProfileUseCase {}

class MockGetDogBreedsUseCase extends Mock implements GetDogBreedsUseCase {}

class MockHasDogProfileDraftUseCase extends Mock
    implements HasDogProfileDraftUseCase {}

class FakeDogProfile extends Fake implements DogProfile {}

void main() {
  late DogProfileBloc bloc;
  late MockSaveDogProfileDraftUseCase saveDogProfileDraft;
  late MockLoadDogProfileDraftUseCase loadDogProfileDraft;
  late MockClearDogProfileDraftUseCase clearDogProfileDraft;
  late MockGetCurrentAddress getCurrentAddress;
  late MockCreateDogProfileUseCase createDogProfile;
  late MockGetDogBreedsUseCase getDogBreeds;
  late MockHasDogProfileDraftUseCase hasDogProfileDraft;

  setUpAll(() {
    registerFallbackValue(FakeDogProfile());
  });

  setUp(() {
    saveDogProfileDraft = MockSaveDogProfileDraftUseCase();
    loadDogProfileDraft = MockLoadDogProfileDraftUseCase();
    clearDogProfileDraft = MockClearDogProfileDraftUseCase();
    getCurrentAddress = MockGetCurrentAddress();
    createDogProfile = MockCreateDogProfileUseCase();
    getDogBreeds = MockGetDogBreedsUseCase();
    hasDogProfileDraft = MockHasDogProfileDraftUseCase();

    when(() => getDogBreeds.call()).thenAnswer((_) async => []);
    when(() => hasDogProfileDraft.call()).thenAnswer((_) async => false);
    when(() => saveDogProfileDraft.call(any())).thenAnswer((_) async {});
  });

  DogProfileBloc buildBloc() {
    return DogProfileBloc(
      saveDogProfileDraft: saveDogProfileDraft,
      loadDogProfileDraft: loadDogProfileDraft,
      clearDogProfileDraft: clearDogProfileDraft,
      getCurrentAddress: getCurrentAddress,
      createDogProfile: createDogProfile,
      getDogBreeds: getDogBreeds,
      hasDogProfileDraft: hasDogProfileDraft,
    );
  }

  group('DogProfileBloc', () {
    blocTest<DogProfileBloc, DogProfileState>(
      'ProfileStarted - No Draft',
      build: buildBloc,
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<DogProfileState>().having(
          (s) => s.availableBreeds,
          'breeds',
          isEmpty,
        ),
        isA<DogProfileState>().having((s) => s.ready, 'ready', true),
      ],
    );

    blocTest<DogProfileBloc, DogProfileState>(
      'BreedSelected emits state with new breed',
      build: buildBloc,
      wait: const Duration(milliseconds: 100),
      act: (bloc) {
        final breed = Breed(id: 1, name: 'Labrador');
        bloc.add(BreedSelected(breed: breed));
      },
      expect: () => contains(
        isA<DogProfileState>().having(
          (s) => s.dogProfile?.breed?.name,
          'breed name',
          'Labrador',
        ),
      ),
    );

    blocTest<DogProfileBloc, DogProfileState>(
      'NextStep increments step and saves draft',
      build: buildBloc,
      wait: const Duration(milliseconds: 100),
      act: (bloc) {
        bloc.add(NextStep());
      },
      expect: () => contains(
        isA<DogProfileState>().having((s) => s.currentStep, 'step 1', 1),
      ),
      verify: (bloc) {
        verify(() => saveDogProfileDraft(any())).called(1);
      },
    );

    blocTest<DogProfileBloc, DogProfileState>(
      'PreviousStep decrements step',
      build: buildBloc,
      wait: const Duration(milliseconds: 100),
      seed: () => DogProfileState.initial().copyWith(currentStep: 1),
      act: (bloc) {
        bloc.add(PreviousStep());
      },
      expect: () => contains(
        isA<DogProfileState>().having((s) => s.currentStep, 'step 0', 0),
      ),
    );

    group('GetAddressEvent', () {
      test('GetAddressEvent Success', () async {
        // Since we can't easily skip initial events with `test` (blocTest handles it),
        // we'll rely on blocTest
      });

      blocTest<DogProfileBloc, DogProfileState>(
        'emits loading then address on success',
        build: () {
          when(
            () => getCurrentAddress(),
          ).thenAnswer((_) async => '123 Fake St');
          return buildBloc();
        },
        wait: const Duration(milliseconds: 100),
        act: (bloc) => bloc.add(GetAddressEvent()),
        expect: () => contains(
          isA<DogProfileState>().having(
            (s) => s.dogProfile?.owner?.address,
            'address',
            '123 Fake St',
          ),
        ),
      );

      blocTest<DogProfileBloc, DogProfileState>(
        'emits error message on PermissionDenied',
        build: () {
          when(
            () => getCurrentAddress(),
          ).thenAnswer((_) async => throw LocationPermissionDenied());
          return buildBloc();
        },
        wait: const Duration(milliseconds: 100),
        act: (bloc) => bloc.add(GetAddressEvent()),
        expect: () => contains(
          isA<DogProfileState>().having(
            (s) => s.errorMessage,
            'error',
            contains('Debes permitir el acceso'),
          ),
        ),
      );
    });

    group('CreateDogProfileRequested', () {
      blocTest<DogProfileBloc, DogProfileState>(
        'emits finished on success',
        build: () {
          when(() => createDogProfile(any())).thenAnswer((_) async => true);
          return buildBloc();
        },
        wait: const Duration(milliseconds: 100),
        act: (bloc) => bloc.add(
          CreateDogProfileRequested(dogProfile: DogProfile(owner: Owner())),
        ),
        expect: () => contains(
          isA<DogProfileState>().having((s) => s.finished, 'finished', true),
        ),
      );

      blocTest<DogProfileBloc, DogProfileState>(
        'emits error on failure',
        build: () {
          when(
            () => createDogProfile(any()),
          ).thenAnswer((_) async => throw Exception('Failed'));
          return buildBloc();
        },
        wait: const Duration(milliseconds: 100),
        act: (bloc) => bloc.add(
          CreateDogProfileRequested(dogProfile: DogProfile(owner: Owner())),
        ),
        expect: () => contains(
          isA<DogProfileState>().having(
            (s) => s.errorMessage,
            'error',
            'Exception: Failed',
          ),
        ),
      );
    });
  });
}

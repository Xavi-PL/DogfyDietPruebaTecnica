import 'package:dogfy_diet_prueba_tecnica/core/utils/date_utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_state.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/view/profile_wizard_step.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_breed_selector_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_date_dropdown_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_more_than_one_dog_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_name_input_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_segmented_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileWizardScreen extends StatefulWidget {
  const DogProfileWizardScreen({super.key});

  @override
  State<DogProfileWizardScreen> createState() => _DogProfileWizardScreenState();
}

class _DogProfileWizardScreenState extends State<DogProfileWizardScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogProfileBloc(),
      child: BlocListener<DogProfileBloc, DogProfileState>(
        listenWhen: (prev, next) => prev.currentStep != next.currentStep,
        listener: (context, state) {
          _controller.animateToPage(
            state.currentStep,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        },
        child: BlocBuilder<DogProfileBloc, DogProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Dogfy Diet')),
              backgroundColor: Colors.white,
              body: PageView(
                controller: _controller,
                children: buildSteps(context, state),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildSteps(BuildContext context, DogProfileState state) {
    return [
      buildDogBreedStep(context, state),
      buildDogNameStep(context, state),
      buildDogGenderAndSterilizedStep(context, state),
      buildDogBirthDateStep(context, state),
    ];
  }

  Widget buildDogBreedStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '🐶',
      state: state,
      title: '¿Cuál es la raza de tu perrete?',
      content: [
        ProfileBreedSelectorWidget(
          onBreedSelected: (breed) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(BreedSelected(breed: breed)),
          availableBreeds: state.availableBreeds,
        ),
      ],
    );
  }

  Widget buildDogNameStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '✏️',
      state: state,
      title: '¿Cómo se llama tu perrete?',
      description:
          '¡Qué emoción! Estás a punto de mejorar la vida de tu perrete a través de una alimentación 100% natural.',
      content: [
        ProfileNameInputWidget(
          onNameChanged: (dogName) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogNameSet(dogName: dogName)),
        ),
        SizedBox(height: 20),
        ProfileMoreThanOneDogWidget(),
      ],
    );
  }

  Widget buildDogGenderAndSterilizedStep(
    BuildContext context,
    DogProfileState state,
  ) {
    return DogProfileWizardStep(
      emoji: '🧐',
      title: '¡Queremos conocer a ${state.dogProfile?.name}!',
      description:
          '¿Por qué es importante? Después de la esterilización, se requieren ajustes en la ración, ya que el perro suele tener menor gasto calórico.',
      content: [
        ProfileSegmentedSelectorWidget(
          selected: state.dogProfile?.sex,
          options: [
            ProfileSegmentedSelectorOption(value: DogSex.male, label: 'Macho'),
            ProfileSegmentedSelectorOption(
              value: DogSex.female,
              label: 'Hembra',
            ),
          ],
          onOptionSelected: (option) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogSexSet(sex: option!)),
        ),
        SizedBox(height: 30),
        Center(
          child: Text(
            state.dogProfile?.sex != null
                ? state.dogProfile!.sex == DogSex.male
                      ? '¿Está esterilizado?'
                      : '¿Está esterilizada?'
                : '¿Está esterilizado/a?',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 15),

        ProfileSegmentedSelectorWidget(
          selected: state.dogProfile?.sterilized,
          options: [
            ProfileSegmentedSelectorOption(value: true, label: 'Sí'),
            ProfileSegmentedSelectorOption(value: false, label: 'No'),
          ],
          onOptionSelected: (option) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogSterilizedSet(sterilized: option!)),
        ),
      ],
      state: state,
    );
  }

  Widget buildDogBirthDateStep(BuildContext context, DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '🎂',
      title: '¿Cuándo nació ${state.dogProfile?.name}?',
      content: [
        ProfileDateDropdownWidget(
          hint: 'Mes',
          options: DateUtilities.getMonthNames(),
          onDateSelected: (month) =>
              BlocProvider.of<DogProfileBloc>(context).add(
                DogBirthMonthSelected(
                  month: DateUtilities.getMonthIndex(month),
                ),
              ),
        ),
        SizedBox(height: 16),
        ProfileDateDropdownWidget(
          hint: 'Año',
          options: List.generate(
            DateTime.now().year - 2006 + 1,
            (index) => index + 2006,
          ),
          onDateSelected: (year) => BlocProvider.of<DogProfileBloc>(
            context,
          ).add(DogBirthYearSelected(year: year)),
        ),
      ],
      state: state,
    );
  }
}

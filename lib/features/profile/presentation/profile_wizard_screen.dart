import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_state.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_wizard_step.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_breed_selector_widget.dart';
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
    _controller = PageController(initialPage: 0);
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
      content: [],
    );
  }
}

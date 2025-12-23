import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogProfileBloc(),
      child: BlocBuilder<DogProfileBloc, DogProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Dogfy Diet')),
            backgroundColor: Colors.white,
            body: PageView(children: buildSteps(state)),
          );
        },
      ),
    );
  }

  List<Widget> buildSteps(DogProfileState state) {
    return [buildDogBreedStep(state)];
  }

  Widget buildDogBreedStep(DogProfileState state) {
    return DogProfileWizardStep(
      emoji: '🐶',
      title: '¿Cuál es la raza de tu perrete?',
      content: [
        ProfileBreedSelectorWidget(
          onBreedSelected: (breed) =>
              context.read<DogProfileBloc>().add(BreedSelected(breed: breed)),
          availableBreeds: state.availableBreeds,
        ),
      ],
    );
  }
}

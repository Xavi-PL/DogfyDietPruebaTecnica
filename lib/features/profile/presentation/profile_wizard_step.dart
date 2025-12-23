import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/profile_state.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_step_icon_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_step_next_button_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogProfileWizardStep extends StatelessWidget {
  final String emoji;
  final String title;
  final List<Widget> content;
  final DogProfileState state;
  final String? description;

  const DogProfileWizardStep({
    super.key,
    required this.emoji,
    required this.title,
    required this.content,
    required this.state,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 75),
                ProfileStepIconWidget(emoji: emoji),
                SizedBox(height: 30),
                Center(
                  child: Text(title, style: const TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 20),
                ...content,
                if (description != null) SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffedf8f8),
                  ),
                  child: Text(description!, style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          ProfileStepNextButtonWidget(onPressed: () => validateStep(context)),
        ],
      ),
    );
  }

  void validateStep(BuildContext context) {
    if (state.isStepValid()) {
      BlocProvider.of<DogProfileBloc>(context).add(NextStep());
    }
  }
}

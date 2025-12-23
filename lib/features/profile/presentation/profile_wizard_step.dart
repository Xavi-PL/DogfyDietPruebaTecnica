import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_step_icon_widget.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_step_next_button_widget.dart';
import 'package:flutter/widgets.dart';

class DogProfileWizardStep extends StatelessWidget {
  final String emoji;
  final String title;
  final List<Widget> content;

  const DogProfileWizardStep({
    super.key,
    required this.emoji,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 75),
                ProfileStepIconWidget(emoji: emoji),
                SizedBox(height: 30),
                Text(title, style: const TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Column(children: content),
              ],
            ),
          ),
          ProfileStepNextButtonWidget(onPressed: () {}),
        ],
      ),
    );
  }
}

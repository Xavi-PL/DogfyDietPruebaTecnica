import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_button_widget.dart';
import 'package:flutter/material.dart';

class ProfileStepNextButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final bool lastStep;
  const ProfileStepNextButtonWidget({
    super.key,
    required this.onPressed,
    this.lastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileButtonWidget(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onPressed();
      },
      text: lastStep ? "Finalizar" : "Continuar",
    );
  }
}

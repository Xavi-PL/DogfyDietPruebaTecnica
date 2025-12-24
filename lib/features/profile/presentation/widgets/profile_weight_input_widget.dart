import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileWeightInputWidget extends StatelessWidget {
  final double? currentWeight;
  final Function(double) onWeightChanged;

  const ProfileWeightInputWidget({
    super.key,
    required this.onWeightChanged,
    this.currentWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'El peso de Kobe es más o menos de',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: ProfileInputTextWidget(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.deny(',', replacementString: '.'),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (weight) => onWeightChanged(double.parse(weight)),
            label: 'Kilogramos (kg)',
            value: currentWeight?.toString() ?? '',
          ),
        ),
      ],
    );
  }
}

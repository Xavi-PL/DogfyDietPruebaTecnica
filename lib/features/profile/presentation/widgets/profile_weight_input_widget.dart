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
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.deny(',', replacementString: '.'),
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})')),
            ],
            onChanged: (weight) => onWeightChanged(double.parse(weight)),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Kilogramos (kg)'),
            ),
          ),
        ),
      ],
    );
  }
}

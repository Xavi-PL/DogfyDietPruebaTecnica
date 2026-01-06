import 'package:dogfy_diet_prueba_tecnica/core/utils/input_utilities.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWeightInputWidget extends StatelessWidget {
  final String? currentWeight;
  final Function(String) onWeightChanged;

  const ProfileWeightInputWidget({
    super.key,
    required this.onWeightChanged,
    this.currentWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'El peso de ${context.read<DogProfileBloc>().state.dogProfile?.name} es más o menos de',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: ProfileInputTextWidget(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.deny(',', replacementString: '.'),
              TwoDecimalInputFormatter(),
            ],
            onChanged: (weight) => onWeightChanged(weight),
            label: 'Kilogramos (kg)',
            value: currentWeight?.toString() ?? '',
          ),
        ),
      ],
    );
  }
}

import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNameInputWidget extends StatelessWidget {
  final String name;
  final Function(String) onNameChanged;

  const ProfileNameInputWidget({
    super.key,
    required this.onNameChanged,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          BlocProvider.of<DogProfileBloc>(context).add(MoreThanOneDogTapped()),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(child: Text('🐶', style: TextStyle(fontSize: 36))),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ProfileInputTextWidget(
              value: name,
              onChanged: onNameChanged,
              label: 'Mi perrhijo se llama...',
              keyboardType: TextInputType.name,
            ),
          ),
        ],
      ),
    );
  }
}

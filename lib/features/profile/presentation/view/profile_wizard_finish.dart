import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/bloc/profile_event.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/presentation/widgets/profile_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWizardFinish extends StatelessWidget {
  const ProfileWizardFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 100, color: Color(0xffffd44a)),
          SizedBox(height: 16),
          Center(
            child: Text(
              'Perfil creado correctamente',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 16),
          ProfileButtonWidget(
            onPressed: () =>
                BlocProvider.of<DogProfileBloc>(context).add(NewProfile()),
            text: 'Añadir otro perfil',
          ),
        ],
      ),
    );
  }
}

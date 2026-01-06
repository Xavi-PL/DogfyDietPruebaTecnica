import 'package:flutter/material.dart';

class ProfileMoreThanOneDogWidget extends StatelessWidget {
  const ProfileMoreThanOneDogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Tienes más de un perro?',
          style: TextStyle(fontSize: 16, color: Color(0xff0b7373)),
        ),
        SizedBox(width: 16),
        Icon(Icons.add_circle_outline_rounded, color: Color(0xff0b7373)),
      ],
    );
  }
}

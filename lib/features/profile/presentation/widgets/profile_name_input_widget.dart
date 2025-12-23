import 'package:flutter/material.dart';

class ProfileNameInputWidget extends StatelessWidget {
  final Function(String) onNameChanged;

  const ProfileNameInputWidget({super.key, required this.onNameChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
            border: Border.all(color: Colors.grey),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nombre',
            ),
          ),
        ),
      ],
    );
  }
}

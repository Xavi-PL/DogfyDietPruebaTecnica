import 'package:flutter/material.dart';

class ProfileStepIconWidget extends StatelessWidget {
  final String emoji;
  const ProfileStepIconWidget({super.key, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
          color: Color(0xffedf8f8),
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 50))),
      ),
    );
  }
}

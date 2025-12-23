import 'package:flutter/material.dart';

class ProfileStepNextButtonWidget extends StatelessWidget {
  final Function() onPressed;
  const ProfileStepNextButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffef6948),
      borderRadius: BorderRadius.all(Radius.circular(360)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Center(
            child: Text(
              "Continuar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

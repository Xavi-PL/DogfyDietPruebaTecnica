import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileInputTextWidget extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final IconData? icon;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;

  const ProfileInputTextWidget({
    super.key,
    required this.onChanged,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters = const [],
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}

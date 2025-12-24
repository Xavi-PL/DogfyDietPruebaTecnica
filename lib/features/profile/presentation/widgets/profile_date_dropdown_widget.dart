import 'package:flutter/material.dart';

class ProfileDateDropdownWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> options;
  final Function(T) onDateSelected;
  final String? hint;
  const ProfileDateDropdownWidget({
    super.key,
    required this.options,
    required this.onDateSelected,
    this.selectedValue,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<T>(
        value: selectedValue,
        isExpanded: true,
        hint: Text(hint ?? ''),
        underline: const SizedBox(),
        menuMaxHeight: 200,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option.toString()),
          );
        }).toList(),
        onChanged: (option) {
          if (option != null) {
            onDateSelected(option);
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileDateDropdownWidget<T> extends StatelessWidget {
  final List<T> options;
  final Function(T) onDateSelected;
  final String? hint;
  const ProfileDateDropdownWidget({
    super.key,
    required this.options,
    required this.onDateSelected,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: hint,
      width: double.infinity,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      menuStyle: MenuStyle(
        elevation: WidgetStatePropertyAll(5),
        alignment: Alignment.bottomLeft, // forces menu below
      ),
      alignmentOffset: const Offset(0, 8),
      dropdownMenuEntries: options
          .map(
            (option) =>
                DropdownMenuEntry(value: option, label: option.toString()),
          )
          .toList(),
      onSelected: (option) => onDateSelected(option!),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileSegmentedSelectorWidget<T> extends StatelessWidget {
  final List<ProfileSegmentedSelectorOption<T>> options;
  final Function(T?) onOptionSelected;
  final T? selected;

  const ProfileSegmentedSelectorWidget({
    super.key,
    required this.options,
    required this.onOptionSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xffffee99);
            }
            return Colors.transparent;
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(360)),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: Color(0xffffd44a), width: 1),
          ),
        ),
        selected: {selected},
        segments: options
            .map(
              (option) =>
                  ButtonSegment(value: option.value, label: Text(option.label)),
            )
            .toList(),
        onSelectionChanged: (selected) => onOptionSelected(selected.first),
      ),
    );
  }
}

class ProfileSegmentedSelectorOption<T> {
  final T value;
  final String label;

  const ProfileSegmentedSelectorOption({
    required this.value,
    required this.label,
  });
}

import 'package:flutter/material.dart';

class ProfileRowSelectorWidget<T> extends StatelessWidget {
  final List<ProfileRowSelectorOption<T>> options;
  final Function(T) onSelected;
  final T? selected;
  const ProfileRowSelectorWidget({
    super.key,
    required this.options,
    required this.onSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = options
        .map(
          (option) => ProfileRowSelectorItemWidget(
            option: option,
            description: option.description,
            isSelected: selected == option.option,
            onSelected: (option) => onSelected(option),
          ),
        )
        .toList();

    return Column(
      children: [
        const Text(
          'Selecciona la figura que más se asemeja en cuanto a su peso y forma',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: sizes.length,
          itemBuilder: (context, index) => sizes[index],
        ),
      ],
    );
  }
}

class ProfileRowSelectorItemWidget<T> extends StatelessWidget {
  final ProfileRowSelectorOption<T> option;
  final String description;
  final bool isSelected;
  final Function(T) onSelected;

  const ProfileRowSelectorItemWidget({
    super.key,
    required this.option,
    required this.description,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(option.option),
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.5,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(255, 255, 247, 209)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Color(0xffffd44a) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/${option.asset}'),
              ),
              SizedBox(width: 16),
              Expanded(child: Text(description)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileRowSelectorOption<T> {
  final T option;
  final String label;
  final String description;
  final String asset;

  const ProfileRowSelectorOption({
    required this.option,
    required this.label,
    required this.description,
    required this.asset,
  });
}

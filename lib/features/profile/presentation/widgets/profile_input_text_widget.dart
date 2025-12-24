import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileInputTextWidget extends StatefulWidget {
  final String value;
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
    required this.value,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters = const [],
    this.icon,
  });

  @override
  State<ProfileInputTextWidget> createState() => _ProfileInputTextWidgetState();
}

class _ProfileInputTextWidgetState extends State<ProfileInputTextWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant ProfileInputTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      final selection = _controller.selection;
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: selection.copyWith(
          baseOffset: widget.value.length.clamp(0, widget.value.length),
          extentOffset: widget.value.length.clamp(0, widget.value.length),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      onChanged: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(widget.label),
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
      ),
    );
  }
}

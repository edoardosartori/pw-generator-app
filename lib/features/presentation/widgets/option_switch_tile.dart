import 'package:flutter/material.dart';

class OptionSwitchTile
    extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const OptionSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      toggled: value,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Expanded(
              child: Text(title),
            ),
            Switch(
              value: value,
              onChanged:
                  onChanged,
            )
          ],
        ),
      ),
    );
  }
}

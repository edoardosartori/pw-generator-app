import 'package:flutter/material.dart';
import 'package:pw_gen/core/theme/fusion_theme_extension.dart';

class PasswordCard extends StatelessWidget {
  final String password;
  final int length;
  final double entropy;

  /// Optional action overlaid on the card's top-left corner
  /// (e.g. the theme toggle in the landscape layout).
  /// It takes no vertical layout space.
  final Widget? action;

  const PasswordCard({
    super.key,
    required this.password,
    required this.length,
    required this.entropy,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FusionThemeExtension>();

    if (ext == null) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: 'Password created. $length characters, ${entropy.round()} bits',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 68,
                    child: Center(
                      child: SelectableText.rich(
                        TextSpan(
                          children: password
                              .split('')
                              .map(
                                (c) => TextSpan(
                                  text: c,
                                  style: TextStyle(
                                    color: _charColor(
                                      c,
                                      ext,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 24,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  if (action != null)
                    Positioned(
                      top: -12,
                      left: -12,
                      child: action!,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '$length characters · '
                '${entropy.round()} bits',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'JetBrains Mono',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _charColor(
    String char,
    FusionThemeExtension ext,
  ) {
    final digit = RegExp(r'\d');

    final letter = RegExp(r'[a-zA-Z]');

    if (digit.hasMatch(char)) {
      return ext.characterDigit;
    }

    if (letter.hasMatch(char)) {
      return ext.characterLetter;
    }

    return ext.characterSymbol;
  }
}

import 'package:flutter/material.dart';
import 'package:pw_gen/core/theme/fusion_theme_extension.dart';

class PasswordCard extends StatelessWidget {
  final String password;
  final int length;
  final double entropy;

  const PasswordCard({
    super.key,
    required this.password,
    required this.length,
    required this.entropy,
  });

  @override
  Widget build(BuildContext context) {
    final ext =
        Theme.of(context)
            .extension<FusionThemeExtension>()!;

    return Semantics(
      label:
          'Password generata. $length caratteri. ${entropy.round()} bit',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SelectableText.rich(
                TextSpan(
                  children: password
                      .split('')
                      .map(
                        (c) => TextSpan(
                          text: c,
                          style: TextStyle(
                            color:
                                _charColor(
                                  c,
                                  ext,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                style: const TextStyle(
                  fontFamily:
                      'JetBrains Mono',
                  fontSize: 24,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                '$length caratteri · '
                '${entropy.round()} bit',
                style:
                    Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontFamily:
                              'JetBrains Mono',
                        ),
              )
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
    final digit =
        RegExp(r'\d');

    final letter =
        RegExp(r'[a-zA-Z]');

    if (digit.hasMatch(char)) {
      return ext.passwordDigit;
    }

    if (letter.hasMatch(char)) {
      return ext.passwordLetter;
    }

    return ext.passwordSymbol;
  }
}

import 'package:flutter/material.dart';

import 'package:pw_gen/core/theme/fusion_theme_extension.dart';
import 'package:pw_gen/features/password_generator/domain/password_strength.dart';

class StrengthMeter
    extends StatelessWidget {
  final PasswordStrength strength;

  const StrengthMeter({
    super.key,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    final ext =
        Theme.of(context)
            .extension<FusionThemeExtension>()!;

    return Semantics(
      label:
          'Robustezza password ${strength.label}',
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              4,
              (index) {
                final active =
                    index <
                    strength
                        .activeSegments;

                return Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                    height: 6,
                    decoration:
                        BoxDecoration(
                          color: active
                              ? ext.stateActive
                              : ext.track,
                          borderRadius:
                              BorderRadius.circular(
                                3,
                              ),
                        ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            strength.label,
            style: TextStyle(
              color:
                  ext.stateActive,
              fontFamily:
                  'JetBrains Mono',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

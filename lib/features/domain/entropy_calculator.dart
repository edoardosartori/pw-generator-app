import 'dart:math';

import 'password_strength.dart';

class EntropyCalculator {
  const EntropyCalculator._();

  static double calculate({
    required int length,
    required int poolSize,
  }) {
    return length * (log(poolSize) / ln2);
  }

  static PasswordStrength strength(
    double entropy,
  ) {
    if (entropy < 40) {
      return PasswordStrength.weak;
    }

    if (entropy < 60) {
      return PasswordStrength.fair;
    }

    if (entropy < 80) {
      return PasswordStrength.strong;
    }

    return PasswordStrength.veryStrong;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:pw_gen/features/password_generator/domain/entropy_calculator.dart';
import 'package:pw_gen/features/password_generator/domain/password_strength.dart';

void main() {
  test(
    'calculates entropy',
    () {
      final entropy = EntropyCalculator.calculate(
        length: 16,
        poolSize: 72,
      );

      expect(
        entropy.round(),
        99,
      );
    },
  );

  test(
    'weak threshold',
    () {
      expect(
        EntropyCalculator.strength(39),
        PasswordStrength.weak,
      );
    },
  );

  test(
    'fair threshold',
    () {
      expect(
        EntropyCalculator.strength(50),
        PasswordStrength.fair,
      );
    },
  );

  test(
    'strong threshold',
    () {
      expect(
        EntropyCalculator.strength(70),
        PasswordStrength.strong,
      );
    },
  );

  test(
    'very strong threshold',
    () {
      expect(
        EntropyCalculator.strength(90),
        PasswordStrength.veryStrong,
      );
    },
  );
}

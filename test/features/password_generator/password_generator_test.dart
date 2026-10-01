import 'package:flutter_test/flutter_test.dart';
import 'package:pw_gen/features/password_generator/domain/password_generator.dart';
import 'package:pw_gen/features/password_generator/models/password_options.dart';

void main() {
  group(
    'PasswordGenerator',
    () {
      final generator = PasswordGenerator();

      test(
        'generates correct length',
        () {
          final result = generator.generate(
            const PasswordOptions(
              length: 24,
              uppercase: true,
              numbers: true,
              symbols: true,
              avoidAmbiguous: false,
            ),
          );

          expect(
            result.password.length,
            24,
          );
        },
      );

      test(
        'contains uppercase',
        () {
          final result = generator.generate(
            const PasswordOptions(
              length: 16,
              uppercase: true,
              numbers: false,
              symbols: false,
              avoidAmbiguous: false,
            ),
          );

          expect(
            result.password.contains(
              RegExp(r'[A-Z]'),
            ),
            true,
          );
        },
      );

      test(
        'contains numbers',
        () {
          final result = generator.generate(
            const PasswordOptions(
              length: 16,
              uppercase: false,
              numbers: true,
              symbols: false,
              avoidAmbiguous: false,
            ),
          );

          expect(
            result.password.contains(
              RegExp(r'\d'),
            ),
            true,
          );
        },
      );

      test(
        'contains symbols',
        () {
          final result = generator.generate(
            const PasswordOptions(
              length: 16,
              uppercase: false,
              numbers: false,
              symbols: true,
              avoidAmbiguous: false,
            ),
          );

          expect(
            result.password.contains(
              RegExp(
                r'[!@#\$%^&*()_+\-\=\[\]{}<>?]',
              ),
            ),
            true,
          );
        },
      );

      test(
        'excludes ambiguous characters',
        () {
          final result = generator.generate(
            const PasswordOptions(
              length: 32,
              uppercase: true,
              numbers: true,
              symbols: true,
              avoidAmbiguous: true,
            ),
          );

          expect(
            result.password.contains('O'),
            false,
          );

          expect(
            result.password.contains('0'),
            false,
          );

          expect(
            result.password.contains('I'),
            false,
          );

          expect(
            result.password.contains('l'),
            false,
          );

          expect(
            result.password.contains('1'),
            false,
          );
        },
      );
    },
  );
}

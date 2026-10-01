import 'dart:math';

import '../models/password_options.dart';
import '../models/password_result.dart';
import 'entropy_calculator.dart';

class PasswordGenerator {
  PasswordGenerator();

  static const String lowercase =
      'abcdefghjkmnpqrstuvwxyz';

  static const String uppercase =
      'ABCDEFGHJKLMNPQRSTUVWXYZ';

  static const String numbers =
      '23456789';

  static const String symbols =
      '!@#\$%^&*()_+-=[]{}<>?';

  static const String lowercaseAll =
      'abcdefghijklmnopqrstuvwxyz';

  static const String uppercaseAll =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static const String numbersAll =
      '0123456789';

  static const String symbolsAll =
      '!@#\$%^&*()_+-=[]{}<>?';

  PasswordResult generate(
    PasswordOptions options,
  ) {
    final random = Random.secure();

    final lowercaseSet =
        options.avoidAmbiguous
            ? lowercase
            : lowercaseAll;

    final uppercaseSet =
        options.avoidAmbiguous
            ? uppercase
            : uppercaseAll;

    final numbersSet =
        options.avoidAmbiguous
            ? numbers
            : numbersAll;

    final symbolsSet =
        options.avoidAmbiguous
            ? symbols
            : symbolsAll;

    final requiredSets = <String>[
      lowercaseSet,
    ];

    if (options.uppercase) {
      requiredSets.add(uppercaseSet);
    }

    if (options.numbers) {
      requiredSets.add(numbersSet);
    }

    if (options.symbols) {
      requiredSets.add(symbolsSet);
    }

    final poolBuffer = StringBuffer();

    for (final set in requiredSets) {
      poolBuffer.write(set);
    }

    final pool = poolBuffer.toString();

    final chars = <String>[];

    for (final set in requiredSets) {
      chars.add(
        set[random.nextInt(set.length)],
      );
    }

    while (chars.length < options.length) {
      chars.add(
        pool[random.nextInt(pool.length)],
      );
    }

    _shuffle(chars, random);

    final entropy = EntropyCalculator.calculate(
      length: options.length,
      poolSize: pool.length,
    );

    return PasswordResult(
      password: chars.join(),
      entropy: entropy,
      poolSize: pool.length,
      strength:
          EntropyCalculator.strength(entropy),
    );
  }

  void _shuffle(
    List<String> list,
    Random random,
  ) {
    for (
      int i = list.length - 1;
      i > 0;
      i--
    ) {
      final j = random.nextInt(i + 1);

      final tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
  }
}

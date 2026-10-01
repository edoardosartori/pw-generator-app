class CharacterSets {
  const CharacterSets._();

  static const ambiguous = {
    'O',
    '0',
    'I',
    'l',
    '1',
    '|',
  };

  static const lowercase =
      'abcdefghijklmnopqrstuvwxyz';

  static const uppercase =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static const digits =
      '0123456789';

  static const symbols =
      '!@#\$%^&*()_+-=[]{}<>?';

  static String removeAmbiguous(
    String source,
  ) {
    return source
        .split('')
        .where(
          (c) => !ambiguous.contains(c),
        )
        .join();
  }
}

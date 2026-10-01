class PasswordOptions {
  final int length;
  final bool uppercase;
  final bool numbers;
  final bool symbols;
  final bool avoidAmbiguous;

  const PasswordOptions({
    required this.length,
    required this.uppercase,
    required this.numbers,
    required this.symbols,
    required this.avoidAmbiguous,
  });

  const PasswordOptions.initial()
      : length = 16,
        uppercase = true,
        numbers = true,
        symbols = true,
        avoidAmbiguous = false;

  PasswordOptions copyWith({
    int? length,
    bool? uppercase,
    bool? numbers,
    bool? symbols,
    bool? avoidAmbiguous,
  }) {
    return PasswordOptions(
      length: length ?? this.length,
      uppercase: uppercase ?? this.uppercase,
      numbers: numbers ?? this.numbers,
      symbols: symbols ?? this.symbols,
      avoidAmbiguous: avoidAmbiguous ?? this.avoidAmbiguous,
    );
  }
}

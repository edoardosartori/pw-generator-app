enum PasswordStrength {
  weak,
  fair,
  strong,
  veryStrong,
}

extension PasswordStrengthX on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Debole';

      case PasswordStrength.fair:
        return 'Discreta';

      case PasswordStrength.strong:
        return 'Forte';

      case PasswordStrength.veryStrong:
        return 'Molto forte';
    }
  }

  int get activeSegments {
    switch (this) {
      case PasswordStrength.weak:
        return 1;

      case PasswordStrength.fair:
        return 2;

      case PasswordStrength.strong:
        return 3;

      case PasswordStrength.veryStrong:
        return 4;
    }
  }
}

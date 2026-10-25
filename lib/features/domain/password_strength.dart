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
        return 'Weak';

      case PasswordStrength.fair:
        return 'Good';

      case PasswordStrength.strong:
        return 'Strong';

      case PasswordStrength.veryStrong:
        return 'Very Strong';
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

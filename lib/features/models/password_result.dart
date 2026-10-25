import '../domain/password_strength.dart';

class PasswordResult {
  final String password;
  final double entropy;
  final int poolSize;
  final PasswordStrength strength;

  const PasswordResult({
    required this.password,
    required this.entropy,
    required this.poolSize,
    required this.strength,
  });
}

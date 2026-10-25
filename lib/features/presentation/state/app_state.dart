import '../../models/password_options.dart';
import '../../models/password_result.dart';

class AppState {
  final PasswordOptions options;
  final PasswordResult result;
  final bool copied;

  const AppState({
    required this.options,
    required this.result,
    this.copied = false,
  });

  AppState copyWith({
    PasswordOptions? options,
    PasswordResult? result,
    bool? copied,
  }) {
    return AppState(
      options: options ?? this.options,
      result: result ?? this.result,
      copied: copied ?? this.copied,
    );
  }
}

import '../../domain/password_generator.dart';
import '../../models/password_options.dart';
import '../../models/password_result.dart';

class PasswordGeneratorState {
  PasswordGeneratorState() : _generator = PasswordGenerator() {
    _options = const PasswordOptions.initial();

    result = _generator.generate(_options);
  }

  final PasswordGenerator _generator;

  late PasswordOptions _options;

  late PasswordResult result;

  PasswordOptions get options => _options;

  void updateOptions(
    PasswordOptions value,
  ) {
    _options = value;

    result = _generator.generate(
      _options,
    );
  }
}

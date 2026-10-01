import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/password_generator.dart';
import '../../models/password_options.dart';
import 'app_state.dart';

class PasswordController extends ValueNotifier<AppState> {
  PasswordController()
      : _generator = PasswordGenerator(),
        super(
          AppState(
            options: const PasswordOptions.initial(),
            result: PasswordGenerator().generate(
              const PasswordOptions.initial(),
            ),
          ),
        );

  final PasswordGenerator _generator;

  Timer? _clipboardTimer;

  void regenerate() {
    value = value.copyWith(
      result: _generator.generate(
        value.options,
      ),
      copied: false,
    );
  }

  void updateOptions(
    PasswordOptions options,
  ) {
    value = value.copyWith(
      options: options,
      result: _generator.generate(options),
      copied: false,
    );
  }

  Future<void> copyPassword() async {
    final password = value.result.password;

// Android 13+:
// Clipboard content should ideally be marked
// as sensitive through a MethodChannel calling
// ClipDescription.EXTRA_IS_SENSITIVE.
// Not implemented here to keep the example
// platform-agnostic.
    await Clipboard.setData(
      ClipboardData(text: password),
    );

    value = value.copyWith(copied: true);

    _clipboardTimer?.cancel();

    _clipboardTimer = Timer(
      const Duration(seconds: 30),
      () async {
        final current = await Clipboard.getData(
          'text/plain',
        );

        if (current?.text == password) {
          await Clipboard.setData(
            const ClipboardData(text: ''),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _clipboardTimer?.cancel();
    super.dispose();
  }
}

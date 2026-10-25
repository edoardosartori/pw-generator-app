import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pw_gen/core/feedback/fusion_toast.dart';

import '../state/app_state.dart';
import '../state/password_controller.dart';
import '../widgets/option_switch_tile.dart';
import '../widgets/password_card.dart';
import '../widgets/strength_meter.dart';

class PortraitLayout extends StatelessWidget {
  final AppState state;
  final PasswordController controller;
  final double refreshTurns;
  final VoidCallback onRefresh;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const PortraitLayout({
    super.key,
    required this.state,
    required this.controller,
    required this.refreshTurns,
    required this.onRefresh,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final options = state.options;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Toggle theme',
                      onPressed: onToggleTheme,
                      icon: Icon(
                        isDarkMode
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 34),
                PasswordCard(
                  password: state.result.password,
                  length: options.length,
                  entropy: state.result.entropy,
                ),
                const SizedBox(height: 20),
                StrengthMeter(strength: state.result.strength),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Text('Length')),
                    Text(options.length.toString()),
                  ],
                ),
                Slider(
                  min: 8,
                  max: 32,
                  divisions: 24,
                  value: options.length.toDouble(),
                  onChanged: (v) {
                    controller.updateOptions(
                      options.copyWith(length: v.round()),
                    );
                  },
                ),
                OptionSwitchTile(
                  title: 'Capital',
                  value: options.uppercase,
                  onChanged: (value) {
                    controller.updateOptions(
                      options.copyWith(uppercase: value),
                    );
                  },
                ),
                OptionSwitchTile(
                  title: 'Numbers',
                  value: options.numbers,
                  onChanged: (value) {
                    controller.updateOptions(
                      options.copyWith(numbers: value),
                    );
                  },
                ),
                OptionSwitchTile(
                  title: 'Symbols',
                  value: options.symbols,
                  onChanged: (value) {
                    controller.updateOptions(
                      options.copyWith(symbols: value),
                    );
                  },
                ),
                OptionSwitchTile(
                  title: 'Avoid Ambiguous',
                  value: options.avoidAmbiguous,
                  onChanged: (value) {
                    controller.updateOptions(
                      options.copyWith(avoidAmbiguous: value),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: () async {
                          await controller.copyPassword();

                          if (!context.mounted) {
                            return;
                          }
                          FusionToast.show(
                            context,
                            message: 'Password copied',
                          );
                        },
                        child: Text(state.copied ? 'Copied' : 'Copy'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onRefresh,
                        child: AnimatedRotation(
                          turns: refreshTurns,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          child: const Icon(Icons.autorenew_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

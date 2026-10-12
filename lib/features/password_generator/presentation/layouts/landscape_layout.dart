import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pw_gen/core/theme/fusion_theme_extension.dart';

import '../state/app_state.dart';
import '../state/password_controller.dart';
import '../widgets/option_switch_tile.dart';
import '../widgets/password_card.dart';
import '../widgets/strength_meter.dart';

class LandscapeLayout extends StatelessWidget {
  final AppState state;
  final PasswordController controller;
  final double refreshTurns;
  final VoidCallback onRefresh;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const LandscapeLayout({
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
    final ext = theme.extension<FusionThemeExtension>()!;

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
        // On wide screens (e.g. tablet landscape) the content
        // never stretches past maxWidth and stays centered.
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: password, strength and actions.
                    // Scrolls on its own if it doesn't fit.
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PasswordCard(
                              password: state.result.password,
                              length: options.length,
                              entropy: state.result.entropy,
                              action: IconButton(
                                tooltip: 'Toggle theme',
                                onPressed: onToggleTheme,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 40,
                                  minHeight: 40,
                                ),
                                icon: Icon(
                                  isDarkMode
                                      ? Icons.light_mode_outlined
                                      : Icons.dark_mode_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            StrengthMeter(
                              strength: state.result.strength,
                            ),
                            const SizedBox(height: 48),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Password copied'),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      state.copied ? 'Copied' : 'Copy',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: onRefresh,
                                    child: AnimatedRotation(
                                      turns: refreshTurns,
                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),
                                      curve: Curves.easeOutCubic,
                                      child: const Icon(
                                        Icons.autorenew_rounded,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right: options in a translucent card
                    // (Fusion card tokens: radius 16, border 1, padding 16).
                    // Scrolls on its own if it doesn't fit.
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ext.surfaceVariant.withValues(alpha: 0.5),
                            border: Border.all(color: ext.border),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
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
                                    options.copyWith(
                                      avoidAmbiguous: value,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

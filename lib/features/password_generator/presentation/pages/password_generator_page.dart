import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../state/password_controller.dart';
import '../widgets/option_switch_tile.dart';
import '../widgets/password_card.dart';
import '../widgets/strength_meter.dart';

class PasswordGeneratorPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const PasswordGeneratorPage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  late final PasswordController controller;
  double _refreshTurns = 0;

  void _animateRefresh() {
    setState(() {
      _refreshTurns += 1;
    });

    controller.regenerate();
  }

  @override
  void initState() {
    super.initState();
    controller = PasswordController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, _) {
        final options = state.options;
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
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
                      children: [
                        Expanded(
                          child: Text(
                            'Generator',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Toggle theme',
                          onPressed: widget.onToggleTheme,
                          icon: Icon(
                            widget.isDarkMode
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Password copied')),
                              );
                            },
                            child: Text(state.copied ? 'Copied' : 'Copy'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _animateRefresh,
                            child: AnimatedRotation(
                              turns: _refreshTurns,
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
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

import '../state/password_controller.dart';
import '../widgets/option_switch_tile.dart';
import '../widgets/password_card.dart';
import '../widgets/strength_meter.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({
    super.key,
  });

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  late final PasswordController controller;

  @override
  void initState() {
    super.initState();

    controller = PasswordController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (
        context,
        state,
        _,
      ) {
        final options = state.options;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Generator',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PasswordCard(
                    password: state.result.password,
                    length: options.length,
                    entropy: state.result.entropy,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StrengthMeter(
                    strength: state.result.strength,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Length',
                        ),
                      ),
                      Text(
                        options.length.toString(),
                      ),
                    ],
                  ),
                  Slider(
                    min: 8,
                    max: 32,
                    divisions: 24,
                    value: options.length.toDouble(),
                    onChanged: (
                      v,
                    ) {
                      controller.updateOptions(
                        options.copyWith(
                          length: v.round(),
                        ),
                      );
                    },
                  ),
                  OptionSwitchTile(
                    title: 'Capital',
                    value: options.uppercase,
                    onChanged: (
                      value,
                    ) {
                      controller.updateOptions(
                        options.copyWith(
                          uppercase: value,
                        ),
                      );
                    },
                  ),
                  OptionSwitchTile(
                    title: 'Numbers',
                    value: options.numbers,
                    onChanged: (
                      value,
                    ) {
                      controller.updateOptions(
                        options.copyWith(
                          numbers: value,
                        ),
                      );
                    },
                  ),
                  OptionSwitchTile(
                    title: 'Symbols',
                    value: options.symbols,
                    onChanged: (
                      value,
                    ) {
                      controller.updateOptions(
                        options.copyWith(
                          symbols: value,
                        ),
                      );
                    },
                  ),
                  OptionSwitchTile(
                    title: 'Avoid Ambiguous',
                    value: options.avoidAmbiguous,
                    onChanged: (
                      value,
                    ) {
                      controller.updateOptions(
                        options.copyWith(
                          avoidAmbiguous: value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
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

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password copied',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            state.copied ? 'Copied' : 'Copy',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.regenerate,
                          child: const Text(
                            'Regenerate',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
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

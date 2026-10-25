import 'package:flutter/material.dart';

import '../layouts/landscape_layout.dart';
import '../layouts/portrait_layout.dart';
import '../state/password_controller.dart';

class PasswordGeneratorPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const PasswordGeneratorPage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
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
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, _) {
        final isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;

        if (isLandscape) {
          return LandscapeLayout(
            state: state,
            controller: controller,
            refreshTurns: _refreshTurns,
            onRefresh: _animateRefresh,
            onToggleTheme: widget.onToggleTheme,
            isDarkMode: widget.isDarkMode,
          );
        }

        return PortraitLayout(
          state: state,
          controller: controller,
          refreshTurns: _refreshTurns,
          onRefresh: _animateRefresh,
          onToggleTheme: widget.onToggleTheme,
          isDarkMode: widget.isDarkMode,
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

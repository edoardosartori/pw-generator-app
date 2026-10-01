import 'package:flutter/material.dart';
import 'core/theme/fusion_tokens.dart';
import 'core/theme/fusion_theme.dart';
import 'core/theme/token_loader.dart';
import 'features/password_generator/presentation/pages/password_generator_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokens = await TokenLoader.load();

  runApp(
    MyApp(tokens: tokens),
  );
}

class MyApp extends StatelessWidget {
  final FusionTokens tokens;

  const MyApp({
    super.key,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FusionTheme.light(tokens),
      darkTheme: FusionTheme.dark(tokens),
      themeMode: ThemeMode.system,
      home: const PasswordGeneratorPage(),
    );
  }
}
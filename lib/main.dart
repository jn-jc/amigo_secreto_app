import 'package:amigo_secreto_app/config/theme/app_theme.dart';
import 'package:amigo_secreto_app/providers/color_theme_provider.dart';
import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => ColorThemeProvider()),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme(selectedColorTheme: context.watch<ColorThemeProvider>().selectedColorTheme).getTheme(),
          home: HomeScreen(),
        ),
      ),
    );
  }
}


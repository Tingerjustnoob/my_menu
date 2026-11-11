import 'package:flutter/material.dart';

import 'menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '麥香堡菜單',
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(textScaler: _LargerTextScaler(media.textScaler)),
          child: child!,
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0866FF),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF0860E8),
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFDCEAFF),
          onPrimaryContainer: const Color(0xFF003B91),
          surface: Colors.white,
          onSurface: const Color(0xFF050505),
          onSurfaceVariant: const Color(0xFF4B4F56),
          outline: const Color(0xFF73777F),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF050505),
          surfaceTintColor: Colors.transparent,
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0866FF),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF75B6FF),
          onPrimary: const Color(0xFF002D62),
          primaryContainer: const Color(0xFF164A80),
          onPrimaryContainer: const Color(0xFFE5F1FF),
          surface: const Color(0xFF242526),
          onSurface: const Color(0xFFE4E6EB),
          onSurfaceVariant: const Color(0xFFBEC3CC),
          outline: const Color(0xFF9299A3),
        ),
        scaffoldBackgroundColor: const Color(0xFF18191A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF242526),
          foregroundColor: Color(0xFFE4E6EB),
          surfaceTintColor: Colors.transparent,
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color(0xFF242526),
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: MenuScreen(
        themeMode: _themeMode,
        onThemeModeChanged: _setThemeMode,
      ),
    );
  }
}

class _LargerTextScaler extends TextScaler {
  const _LargerTextScaler(this.base);

  final TextScaler base;

  @override
  double scale(double fontSize) => base.scale(fontSize * 1.1);

  @override
  double get textScaleFactor => scale(1);
}

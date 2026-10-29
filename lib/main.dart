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
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '餐品介紹',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF8B321A),
          onPrimary: Colors.white,
          surface: Color(0xFFFFFBF5),
          onSurface: Color(0xFF261B16),
          outline: Color(0xFF806E64),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF5),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFBF5), foregroundColor: Color(0xFF261B16), surfaceTintColor: Colors.transparent),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white, surfaceTintColor: Colors.transparent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFB69D),
          onPrimary: Color(0xFF451400),
          surface: Color(0xFF1C1917),
          onSurface: Color(0xFFF6EDE6),
          outline: Color(0xFFB6A39A),
        ),
        scaffoldBackgroundColor: const Color(0xFF1C1917),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1C1917), foregroundColor: Color(0xFFF6EDE6), surfaceTintColor: Colors.transparent),
        dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF302824), surfaceTintColor: Colors.transparent),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MenuScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => MenuScreen(
          isDarkMode: _isDarkMode,
          onToggleTheme: _toggleTheme,
        ),
      },
    );
  }
}

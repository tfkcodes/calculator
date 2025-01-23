import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _primaryColor = Color(0xFF142B4F);

const primaryLightColor = Color(0x0ff1b5ed);
const _background = Color(0xFFF5F7FA);
const _slightGray = Color.fromARGB(255, 221, 225, 235);
const _darkBackground = Color(0xFF1B1B1B);
const _secondary = Color(0xFF0D0D0F);
const _slightBlueBackground = Color(0xFF6A6A6C);

class Themes {
  final lightTheme = ThemeData(
    primaryColor: _primaryColor,
    canvasColor: _slightBlueBackground,
    scaffoldBackgroundColor: _background,
    dividerColor: _slightGray,
    cardColor: Color(0xFF49494A),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: _slightBlueBackground,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    shadowColor: Colors.black.withOpacity(0.1),
    colorScheme: const ColorScheme.light().copyWith(
        primary: _primaryColor,
        secondary: _secondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: _background,
        onSurface: Colors.black87),
    textTheme: _buildTextTheme(Brightness.light),
  );

  final darkTheme = ThemeData(
    canvasColor: _darkBackground,
    scaffoldBackgroundColor: _darkBackground,
    primaryColor: _primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: _darkBackground,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      surface: _darkBackground,
      primary: _darkBackground,
      secondary: _secondary,
      onSecondary: Colors.white,
      onPrimary: Colors.white,
      onSurface: Colors.white70,
    ),
    textTheme: _buildTextTheme(Brightness.dark),
  );

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseTextTheme = brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;

    return baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.light ? Colors.black : Colors.white,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: 18,
        color: brightness == Brightness.light ? Colors.black87 : Colors.white70,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontSize: 14,
        color: brightness == Brightness.light ? Colors.black87 : Colors.white70,
      ),
    );
  }
}

final BoxShadow shadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 0,
  blurRadius: 7,
  offset: const Offset(0, 0.6),
);

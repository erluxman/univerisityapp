import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeStateProvider, ThemeData>(
    (ref) => ThemeStateProvider());

class ThemeStateProvider extends StateNotifier<ThemeData> {
  ThemeStateProvider()
      : super(theme(
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.dark,
        ));

  void toggleDarkMode() {
    final isDarkMode = state.brightness == Brightness.dark;
    state = theme(!isDarkMode);
  }
}

ThemeData theme(bool isDarkMode) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1976d2),
        brightness: isDarkMode ? Brightness.dark : Brightness.light),
    useMaterial3: true);

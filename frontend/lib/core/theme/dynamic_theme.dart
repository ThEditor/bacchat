import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'app_theme.dart';

class DynamicApp extends StatelessWidget {
  final Widget home;

  const DynamicApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightScheme = lightDynamic ?? AppTheme.fallbackLightScheme();

        final darkScheme = darkDynamic ?? AppTheme.fallbackDarkScheme();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bacchat',
          themeMode: ThemeMode.system,
          theme: AppTheme.light(lightScheme),
          darkTheme: AppTheme.dark(darkScheme),
          home: home,
        );
      },
    );
  }
}

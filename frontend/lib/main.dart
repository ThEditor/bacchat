import 'package:flutter/material.dart';
import 'core/theme/dynamic_theme.dart';
import 'features/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BacchatApp());
}

class BacchatApp extends StatelessWidget {
  const BacchatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DynamicApp(home: SplashPage());
  }
}

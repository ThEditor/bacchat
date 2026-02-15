import 'package:flutter/material.dart';
import 'core/theme/dynamic_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BacchatApp());
}

class BacchatApp extends StatelessWidget {
  const BacchatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DynamicApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Bacchat")),
      body: Center(
        child: FilledButton(
          onPressed: () {},
          child: const Text("Material You Button"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

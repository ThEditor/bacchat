import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('BACCHAT'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: colors.primary),
            const SizedBox(height: 24),
            Text(
              'Welcome to BACCHAT!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'The Open Source Split Tracking App',
              style: TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/widgets/material3_loader.dart';

class SplashCenter extends StatelessWidget {
  final double progress;
  
  const SplashCenter({
    super.key,
    this.progress = 0.75, // Default to 75% for static display
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material3Loader(
            size: 250,
            strokeWidth: 32,
            value: progress,
            showAsStatic: true,
            gapAngle: 0.5,
          ),
        ],
      ),
    );
  }
}
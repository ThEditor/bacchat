import 'package:flutter/material.dart';
import 'dart:math' as math;

class Material3Loader extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final double? value;
  final Color? progressColor;
  final Color? trackColor;
  final Duration animationDuration;
  final bool showAsStatic;
  final double gapAngle;

  const Material3Loader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 4.0,
    this.value,
    this.progressColor,
    this.trackColor,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.showAsStatic = false,
    this.gapAngle = 0.1, // ~5.7 degrees
  });

  @override
  State<Material3Loader> createState() => _Material3LoaderState();
}

class _Material3LoaderState extends State<Material3Loader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    // Only animate if indeterminate (value is null) and not static
    if (widget.value == null && !widget.showAsStatic) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(Material3Loader oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle switching between determinate and indeterminate
    if (widget.value == null && oldWidget.value != null && !widget.showAsStatic) {
      _controller.repeat();
    } else if ((widget.value != null || widget.showAsStatic) && oldWidget.value == null) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final effectiveProgressColor = widget.progressColor ?? colors.primary;
    final effectiveTrackColor = widget.trackColor ?? colors.secondary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: widget.showAsStatic
          ? CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _Material3LoaderPainter(
                progress: widget.value ?? 0.75,
                strokeWidth: widget.strokeWidth,
                trackColor: effectiveTrackColor,
                progressColor: effectiveProgressColor,
                isIndeterminate: false,
                showAsStatic: true,
                gapAngle: widget.gapAngle,
              ),
            )
          : widget.value == null
              ? AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(widget.size, widget.size),
                      painter: _Material3LoaderPainter(
                        progress: _controller.value,
                        strokeWidth: widget.strokeWidth,
                        trackColor: effectiveTrackColor,
                        progressColor: effectiveProgressColor,
                        isIndeterminate: true,
                        showAsStatic: false,
                        gapAngle: 0,
                      ),
                    );
                  },
                )
              : CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _Material3LoaderPainter(
                    progress: widget.value!.clamp(0.0, 1.0),
                    strokeWidth: widget.strokeWidth,
                    trackColor: effectiveTrackColor,
                    progressColor: effectiveProgressColor,
                    isIndeterminate: false,
                    showAsStatic: false,
                    gapAngle: 0,
                  ),
                ),
    );
  }
}

class _Material3LoaderPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;
  final bool isIndeterminate;
  final bool showAsStatic;
  final double gapAngle;

  _Material3LoaderPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.progressColor,
    required this.isIndeterminate,
    required this.showAsStatic,
    required this.gapAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (showAsStatic) {
      // Static mode: Draw progress and track with gaps on both sides
      const startAngle = -math.pi / 2; // Start from top
      
      // Progress section starts at top, with gap/2 on each side
      final progressStartAngle = startAngle + (gapAngle / 2);
      final progressSweep = (2 * math.pi * progress) - gapAngle;
      
      // Track section starts after progress + gaps
      final trackStartAngle = progressStartAngle + progressSweep + gapAngle;
      final trackSweep = (2 * math.pi * (1 - progress)) - gapAngle;

      // Draw progress arc (completed section)
      final progressPaint = Paint()
        ..color = progressColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (progress > 0) {
        canvas.drawArc(rect, progressStartAngle, progressSweep, false, progressPaint);
      }

      // Draw track arc (remaining section)
      final trackPaint = Paint()
        ..color = trackColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (progress < 1.0) {
        canvas.drawArc(rect, trackStartAngle, trackSweep, false, trackPaint);
      }
    } else {
      // Original behavior for non-static mode
      
      // Draw track (background circle)
      final trackPaint = Paint()
        ..color = trackColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, radius, trackPaint);

      // Draw progress arc
      final progressPaint = Paint()
        ..color = progressColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (isIndeterminate) {
        // Indeterminate: rotating arc with fixed length
        const arcLength = math.pi * 0.75; // 270 degrees arc
        final startAngle = progress * 2 * math.pi - math.pi / 2;
        canvas.drawArc(rect, startAngle, arcLength, false, progressPaint);
      } else {
        // Determinate: arc from top to progress value
        const startAngle = -math.pi / 2;
        final sweepAngle = 2 * math.pi * progress;
        if (progress > 0) {
          canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_Material3LoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.isIndeterminate != isIndeterminate ||
        oldDelegate.showAsStatic != showAsStatic ||
        oldDelegate.gapAngle != gapAngle;
  }
}
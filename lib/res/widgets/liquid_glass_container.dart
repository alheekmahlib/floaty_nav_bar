import 'dart:math' as math;
import 'dart:ui';

import 'package:floaty_nav_bar/res/models/floaty_glass_effect.dart';
import 'package:flutter/material.dart';

/// A reusable container that renders an iOS 26–style Liquid Glass effect.
///
/// This widget encapsulates the full rendering pipeline:
/// 1. Outer shadow
/// 2. Primary blur via [BackdropFilter]
/// 3. Saturation boost via [ColorFilter.matrix]
/// 4. Specular highlight overlay (top-left white gradient)
/// 5. Inner shadow for depth
/// 6. Frosted noise texture
/// 7. Tint/gradient layer
/// 8. Luminosity-aware border
class LiquidGlassContainer extends StatelessWidget {
  const LiquidGlassContainer({
    super.key,
    required this.glassEffect,
    required this.borderRadius,
    required this.child,
    this.blurScale = 1.0,
  });

  /// The glass effect configuration.
  final FloatyGlassEffect glassEffect;

  /// The border radius for clipping and decoration.
  final BorderRadius borderRadius;

  /// The child widget to display inside the glass container.
  final Widget child;

  /// Scale factor for the blur sigma (e.g., 0.5 for FAB, 1.0 for nav bar).
  final double blurScale;

  @override
  Widget build(BuildContext context) {
    final sigma = glassEffect.blur * blurScale;

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: glassEffect.enableShadow
            ? [
                BoxShadow(
                  color: glassEffect.shadowColor ??
                      Colors.black.withValues(alpha: 0.25),
                  blurRadius: glassEffect.shadowBlur * blurScale,
                  spreadRadius: glassEffect.shadowSpread * blurScale,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            inner: glassEffect.saturationBoost != 1.0
                ? ColorFilter.matrix(
                    _saturationMatrix(glassEffect.saturationBoost),
                  )
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          ),
          child: CustomPaint(
            painter: _LiquidGlassPainter(
              glassEffect: glassEffect,
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Builds a 5×4 color matrix that adjusts saturation.
  ///
  /// A saturation of 1.0 is identity; > 1.0 boosts, < 1.0 desaturates.
  static List<double> _saturationMatrix(double saturation) {
    final s = saturation;
    const lumR = 0.2126;
    const lumG = 0.7152;
    const lumB = 0.0722;
    return <double>[
      lumR * (1 - s) + s, lumG * (1 - s), lumB * (1 - s), 0, 0, //
      lumR * (1 - s), lumG * (1 - s) + s, lumB * (1 - s), 0, 0, //
      lumR * (1 - s), lumG * (1 - s), lumB * (1 - s) + s, 0, 0, //
      0, 0, 0, 1, 0, //
    ];
  }
}

/// Custom painter that renders the Liquid Glass layers on top of the
/// blurred/saturated backdrop: tint, specular highlight, inner shadow, noise.
class _LiquidGlassPainter extends CustomPainter {
  _LiquidGlassPainter({
    required this.glassEffect,
    required this.borderRadius,
  });

  final FloatyGlassEffect glassEffect;
  final BorderRadius borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.resolve(TextDirection.ltr).toRRect(rect);

    canvas.save();
    canvas.clipRRect(rrect);

    // Layer 1: Tint / gradient background
    _paintTint(canvas, rect);

    // Layer 2: Specular highlight
    if (glassEffect.specularHighlight) {
      _paintSpecularHighlight(canvas, rect);
    }

    // Layer 3: Inner shadow
    if (glassEffect.innerShadow) {
      _paintInnerShadow(canvas, rect, rrect);
    }

    // Layer 4: Frosted noise texture
    if (glassEffect.noiseOpacity > 0) {
      _paintNoise(canvas, rect);
    }

    // Layer 5: Border
    if (glassEffect.borderWidth > 0) {
      _paintBorder(canvas, rrect);
    }

    canvas.restore();
  }

  void _paintTint(Canvas canvas, Rect rect) {
    final paint = Paint();
    if (glassEffect.gradient != null) {
      paint.shader = glassEffect.gradient!.createShader(rect);
    } else {
      paint.color = (glassEffect.tintColor ?? Colors.white)
          .withValues(alpha: glassEffect.opacity);
    }
    canvas.drawRect(rect, paint);
  }

  void _paintSpecularHighlight(Canvas canvas, Rect rect) {
    // Top-edge light refraction: bright at top-left fading to transparent
    final highlightPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0x18FFFFFF),
          Color(0x0AFFFFFF),
          Color(0x00FFFFFF),
        ],
        stops: [0.0, 0.35, 0.7],
      ).createShader(rect);
    canvas.drawRect(rect, highlightPaint);

    // Additional top-edge highlight bar
    final topBarRect = Rect.fromLTWH(0, 0, rect.width, rect.height * 0.35);
    final topBarPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.12),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(topBarRect);
    canvas.drawRect(topBarRect, topBarPaint);
  }

  void _paintInnerShadow(Canvas canvas, Rect rect, RRect rrect) {
    // Top inner shadow (subtle depth from the top edge)
    final topShadowRect = Rect.fromLTWH(0, 0, rect.width, rect.height * 0.4);
    final topShadowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withValues(alpha: 0.06),
          Colors.black.withValues(alpha: 0.0),
        ],
      ).createShader(topShadowRect);
    canvas.drawRect(topShadowRect, topShadowPaint);

    // Bottom inner shadow
    final bottomShadowRect =
        Rect.fromLTWH(0, rect.height * 0.7, rect.width, rect.height * 0.3);
    final bottomShadowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withValues(alpha: 0.0),
          Colors.black.withValues(alpha: 0.04),
        ],
      ).createShader(bottomShadowRect);
    canvas.drawRect(bottomShadowRect, bottomShadowPaint);
  }

  void _paintNoise(Canvas canvas, Rect rect) {
    // Simulate frosted noise with a pseudo-random dot pattern
    final noisePaint = Paint()
      ..color = Colors.white.withValues(alpha: glassEffect.noiseOpacity)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent pattern
    final dotCount = (rect.width * rect.height / 60).clamp(50, 500).toInt();
    for (var i = 0; i < dotCount; i++) {
      final x = random.nextDouble() * rect.width;
      final y = random.nextDouble() * rect.height;
      canvas.drawCircle(Offset(x, y), 0.5, noisePaint);
    }
  }

  void _paintBorder(Canvas canvas, RRect rrect) {
    // Luminosity-aware border: brighter on top, dimmer on bottom
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = glassEffect.borderWidth
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          glassEffect.borderColor ?? Colors.white.withValues(alpha: 0.35),
          (glassEffect.borderColor ?? Colors.white.withValues(alpha: 0.35))
              .withValues(alpha: 0.08),
        ],
      ).createShader(rrect.outerRect);
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassPainter oldDelegate) {
    return oldDelegate.glassEffect != glassEffect ||
        oldDelegate.borderRadius != borderRadius;
  }
}

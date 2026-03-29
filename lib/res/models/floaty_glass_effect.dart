import 'package:flutter/material.dart';

/// Defines the variant of the Liquid Glass effect.
///
/// Mirrors iOS 26's two Liquid Glass variants:
/// - [regular]: More opaque, higher blur — maintains legibility for text-heavy elements.
/// - [clear]: Highly translucent — ideal for floating over visually rich backgrounds.
enum LiquidGlassVariant {
  /// More opaque with higher blur. Best for elements with text content.
  regular,

  /// Highly translucent. Best for floating over photos/videos/rich backgrounds.
  clear,
}

/// Configuration for glassmorphism / Liquid Glass effect.
///
/// Provides both classic glassmorphism and iOS 26–style Liquid Glass effects.
/// Use the named constructors for quick presets:
/// - [FloatyGlassEffect.light] — classic light glass.
/// - [FloatyGlassEffect.dark] — classic dark glass.
/// - [FloatyGlassEffect.liquidGlass] — iOS 26 regular Liquid Glass.
/// - [FloatyGlassEffect.liquidGlassClear] — iOS 26 clear Liquid Glass.
class FloatyGlassEffect {
  /// Creates a glassmorphism effect configuration.
  const FloatyGlassEffect({
    this.blur = 10.0,
    this.opacity = 0.2,
    this.tintColor,
    this.gradient,
    this.borderColor,
    this.borderWidth = 1.0,
    this.enableShadow = true,
    this.shadowColor,
    this.shadowBlur = 10.0,
    this.shadowSpread = 0.0,
    this.specularHighlight = false,
    this.innerShadow = false,
    this.saturationBoost = 1.0,
    this.noiseOpacity = 0.0,
    this.variant = LiquidGlassVariant.regular,
  });

  /// Creates a dark glass effect preset with gradient.
  const FloatyGlassEffect.dark({
    this.blur = 20.0,
    this.opacity = 0.3,
    this.tintColor,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x4D2A2A2A),
        Color(0x661A1A1A),
        Color(0x802A2A2A),
      ],
    ),
    this.borderColor = const Color(0x33FFFFFF),
    this.borderWidth = 0.5,
    this.enableShadow = true,
    this.shadowColor = const Color(0x40000000),
    this.shadowBlur = 15.0,
    this.shadowSpread = 2.0,
    this.specularHighlight = false,
    this.innerShadow = false,
    this.saturationBoost = 1.0,
    this.noiseOpacity = 0.0,
    this.variant = LiquidGlassVariant.regular,
  });

  /// Creates a light glass effect preset with gradient.
  const FloatyGlassEffect.light({
    this.blur = 15.0,
    this.opacity = 0.15,
    this.tintColor,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x40FFFFFF),
        Color(0x26FFFFFF),
        Color(0x40FFFFFF),
      ],
    ),
    this.borderColor = const Color(0x40FFFFFF),
    this.borderWidth = 1.0,
    this.enableShadow = true,
    this.shadowColor = const Color(0x20000000),
    this.shadowBlur = 10.0,
    this.shadowSpread = 0.0,
    this.specularHighlight = false,
    this.innerShadow = false,
    this.saturationBoost = 1.0,
    this.noiseOpacity = 0.0,
    this.variant = LiquidGlassVariant.regular,
  });

  /// Creates an iOS 26–style regular Liquid Glass effect.
  ///
  /// Features a multi-layer blur with specular highlights, inner shadow,
  /// subtle noise texture, and saturation boost to mimic the dynamic
  /// Liquid Glass material from iOS 26.
  ///
  /// The regular variant blurs and adjusts the luminosity of background content
  /// to maintain legibility of text and foreground elements.
  const FloatyGlassEffect.liquidGlass({
    this.blur = 25.0,
    this.opacity = 0.12,
    this.tintColor,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x30FFFFFF),
        Color(0x18FFFFFF),
        Color(0x10FFFFFF),
        Color(0x20FFFFFF),
      ],
      stops: [0.0, 0.3, 0.7, 1.0],
    ),
    this.borderColor = const Color(0x50FFFFFF),
    this.borderWidth = 0.5,
    this.enableShadow = true,
    this.shadowColor = const Color(0x30000000),
    this.shadowBlur = 20.0,
    this.shadowSpread = 0.0,
    this.specularHighlight = true,
    this.innerShadow = true,
    this.saturationBoost = 1.3,
    this.noiseOpacity = 0.03,
    this.variant = LiquidGlassVariant.regular,
  });

  /// Creates an iOS 26–style clear Liquid Glass effect.
  ///
  /// Highly translucent, ideal for prioritizing the visibility of underlying
  /// content. Use this for elements that float above media backgrounds
  /// (photos, videos) to create a more immersive experience.
  const FloatyGlassEffect.liquidGlassClear({
    this.blur = 18.0,
    this.opacity = 0.06,
    this.tintColor,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x18FFFFFF),
        Color(0x0CFFFFFF),
        Color(0x08FFFFFF),
        Color(0x14FFFFFF),
      ],
      stops: [0.0, 0.3, 0.7, 1.0],
    ),
    this.borderColor = const Color(0x38FFFFFF),
    this.borderWidth = 0.5,
    this.enableShadow = true,
    this.shadowColor = const Color(0x20000000),
    this.shadowBlur = 12.0,
    this.shadowSpread = 0.0,
    this.specularHighlight = true,
    this.innerShadow = false,
    this.saturationBoost = 1.15,
    this.noiseOpacity = 0.02,
    this.variant = LiquidGlassVariant.clear,
  });

  /// The blur intensity for the glass effect.
  final double blur;

  /// The opacity of the glass overlay (0.0 to 1.0).
  /// Only used when [gradient] is null.
  final double opacity;

  /// Optional tint color for the glass effect.
  /// Only used when [gradient] is null.
  final Color? tintColor;

  /// Optional gradient for the glass effect.
  /// Takes precedence over [tintColor] and [opacity].
  final Gradient? gradient;

  /// Optional border color for the glass effect.
  final Color? borderColor;

  /// Border width for the glass effect.
  final double borderWidth;

  /// Whether to enable shadow on the glass container.
  final bool enableShadow;

  /// Shadow color for the glass effect.
  final Color? shadowColor;

  /// Shadow blur radius.
  final double shadowBlur;

  /// Shadow spread radius.
  final double shadowSpread;

  /// Whether to enable a specular highlight on the top edge.
  ///
  /// Simulates light refraction by adding a subtle white gradient
  /// from the top-left corner, mimicking iOS 26 Liquid Glass.
  final bool specularHighlight;

  /// Whether to enable an inner shadow for added depth.
  ///
  /// Adds a subtle dark gradient around the inner edges to create
  /// a sense of glass thickness and depth perception.
  final bool innerShadow;

  /// Saturation multiplier for the blurred background content.
  ///
  /// Values > 1.0 boost color saturation (default 1.0 = no change).
  /// iOS 26 Liquid Glass slightly boosts saturation to make blurred
  /// background colors more vibrant.
  final double saturationBoost;

  /// Opacity of the frosted noise texture overlay (0.0 to 1.0).
  ///
  /// A very low value (e.g. 0.02–0.05) adds a subtle frosted texture.
  /// Set to 0.0 to disable.
  final double noiseOpacity;

  /// The Liquid Glass variant (regular or clear).
  ///
  /// [LiquidGlassVariant.regular] is more opaque, suitable for text-heavy elements.
  /// [LiquidGlassVariant.clear] is highly translucent, ideal for media backgrounds.
  final LiquidGlassVariant variant;
}

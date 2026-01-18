import 'package:floaty_nav_bar/res/models/floaty_action_button.dart';
import 'package:flutter/material.dart';

/// Defines what content is displayed in a tab.
///
/// This enum allows customization of what appears in each tab state:
/// - [iconOnly]: Only the icon is shown.
/// - [titleOnly]: Only the title is shown.
/// - [iconAndTitle]: Both icon and title are shown.
enum FloatyTabDisplayMode {
  /// Only the icon is displayed.
  iconOnly,

  /// Only the title is displayed.
  titleOnly,

  /// Both icon and title are displayed.
  iconAndTitle,
}

/// Defines the position of the label relative to the icon.
enum FloatyLabelPosition {
  /// Label is positioned to the right of the icon (horizontal layout).
  right,

  /// Label is positioned below the icon (vertical layout).
  bottom,
}

/// Defines the style of the selection indicator.
enum FloatyIndicatorStyle {
  /// Background color fills the entire tab (default behavior).
  background,

  /// A dot indicator appears below/beside the icon.
  dot,

  /// An underline appears below the tab content.
  underline,

  /// No indicator, only icon/text color changes.
  none,
}

/// Configuration for glassmorphism effect.
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
}

/// A class that represents a tab in a floating navigation bar.
///
/// [FloatyTab] contains information about the tab's state, appearance, and actions.
/// Each tab can have an associated icon, title, and a floating action button for additional functionality.
class FloatyTab {
  /// Creates a [FloatyTab] instance with the specified properties.
  ///
  /// The [isSelected] parameter indicates whether the tab is currently selected.
  /// The [title] parameter sets the text displayed on the tab.
  /// The [onTap] parameter is a callback function that is invoked when the tab is tapped.
  /// The [icon] parameter specifies the icon displayed on the tab.
  /// The [titleStyle] parameter allows customization of the text style for the title.
  /// The [floatyActionButton] parameter can be used to associate a floating action button with the tab.
  /// The [margin] parameter sets the margin around the tab, defaulting to 4 pixels on all sides.
  /// The [selectedColor] and [unselectedColor] parameters define the colors of the tab in selected
  /// and unselected states respectively.
  const FloatyTab({
    required this.isSelected,
    required this.title,
    required this.onTap,
    required this.icon,
    this.titleStyle,
    this.floatyActionButton,
    this.margin = const EdgeInsets.all(4),
    this.selectedColor,
    this.unselectedColor,
    this.selectedDisplayMode = FloatyTabDisplayMode.iconAndTitle,
    this.unselectedDisplayMode = FloatyTabDisplayMode.iconOnly,
    // New modern features
    this.selectedGradient,
    this.unselectedGradient,
    this.badge,
    this.iconSize = 22.0,
    this.selectedIconSize = 24.0,
    this.labelPosition = FloatyLabelPosition.right,
    this.indicatorStyle = FloatyIndicatorStyle.background,
    this.indicatorColor,
    this.borderColor,
    this.borderWidth,
    this.animationDuration,
    this.animationCurve,
    this.enableHaptics = false,
    this.tooltip,
    this.glassEffect,
  });

  /// Indicates whether the tab is currently selected.
  final bool isSelected;

  /// The title text displayed on the tab.
  final String title;

  /// The style applied to the title text.
  final TextStyle? titleStyle;

  /// The icon displayed on the tab.
  final Widget icon;

  /// A callback function that is called when the tab is tapped.
  final VoidCallback onTap;

  /// An optional floating action button associated with the tab.
  final FloatyActionButton? floatyActionButton;

  /// The margin around the tab, defaulting to 4 pixels on all sides.
  final EdgeInsetsGeometry margin;

  /// The color of the tab when it is selected.
  final Color? selectedColor;

  /// The color of the tab when it is unselected.
  final Color? unselectedColor;

  /// The display mode when the tab is selected.
  ///
  /// Determines what is shown when the tab is selected (icon only, title only, or both).
  /// Defaults to [FloatyTabDisplayMode.iconAndTitle].
  final FloatyTabDisplayMode selectedDisplayMode;

  /// The display mode when the tab is not selected.
  ///
  /// Determines what is shown when the tab is not selected (icon only, title only, or both).
  /// Defaults to [FloatyTabDisplayMode.iconOnly].
  final FloatyTabDisplayMode unselectedDisplayMode;

  /// Gradient background when the tab is selected.
  ///
  /// If provided, this takes precedence over [selectedColor].
  final Gradient? selectedGradient;

  /// Gradient background when the tab is unselected.
  ///
  /// If provided, this takes precedence over [unselectedColor].
  final Gradient? unselectedGradient;

  /// A badge widget to display on top of the icon.
  ///
  /// Typically used for notification indicators (dots, numbers, etc.).
  final Widget? badge;

  /// The size of the icon when the tab is not selected.
  ///
  /// Defaults to 22.0.
  final double iconSize;

  /// The size of the icon when the tab is selected.
  ///
  /// Defaults to 24.0.
  final double selectedIconSize;

  /// The position of the label relative to the icon.
  ///
  /// Defaults to [FloatyLabelPosition.right].
  final FloatyLabelPosition labelPosition;

  /// The style of the selection indicator.
  ///
  /// Defaults to [FloatyIndicatorStyle.background].
  final FloatyIndicatorStyle indicatorStyle;

  /// Custom color for the indicator (dot, underline).
  ///
  /// If not provided, uses [selectedColor] or theme primary color.
  final Color? indicatorColor;

  /// Border color for the tab.
  ///
  /// If provided along with [borderWidth], adds a border around the tab.
  final Color? borderColor;

  /// Border width for the tab.
  ///
  /// Must be provided along with [borderColor] to show a border.
  final double? borderWidth;

  /// Custom animation duration for this tab.
  ///
  /// If not provided, uses the default medium duration (400ms).
  final Duration? animationDuration;

  /// Custom animation curve for this tab.
  ///
  /// If not provided, uses [Curves.easeInOut].
  final Curve? animationCurve;

  /// Whether to trigger haptic feedback when the tab is tapped.
  ///
  /// Defaults to false.
  final bool enableHaptics;

  /// Tooltip text to show when long-pressing the tab.
  final String? tooltip;

  /// Glassmorphism effect configuration.
  ///
  /// If provided, applies a glass-like blur effect to the tab background.
  final FloatyGlassEffect? glassEffect;

  /// Creates a copy of the current [FloatyTab] instance with optional modifications.
  ///
  /// This method allows you to create a new [FloatyTab] while preserving the current state,
  /// and selectively updating properties such as [isSelected], [title], [titleStyle], [icon],
  /// [onTap], [floatyActionButton], [margin], [selectedColor], and [unselectedColor].
  /// If a property is not provided, the original value from the current instance will be used.
  FloatyTab copyWith({
    bool? isSelected,
    String? title,
    TextStyle? titleStyle,
    Widget? icon,
    VoidCallback? onTap,
    FloatyActionButton? floatyActionButton,
    EdgeInsetsGeometry? margin,
    Color? selectedColor,
    Color? unselectedColor,
    FloatyTabDisplayMode? selectedDisplayMode,
    FloatyTabDisplayMode? unselectedDisplayMode,
    Gradient? selectedGradient,
    Gradient? unselectedGradient,
    Widget? badge,
    double? iconSize,
    double? selectedIconSize,
    FloatyLabelPosition? labelPosition,
    FloatyIndicatorStyle? indicatorStyle,
    Color? indicatorColor,
    Color? borderColor,
    double? borderWidth,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? enableHaptics,
    String? tooltip,
    FloatyGlassEffect? glassEffect,
  }) {
    return FloatyTab(
      isSelected: isSelected ?? this.isSelected,
      title: title ?? this.title,
      titleStyle: titleStyle ?? this.titleStyle,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
      floatyActionButton: floatyActionButton ?? this.floatyActionButton,
      margin: margin ?? this.margin,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      selectedDisplayMode: selectedDisplayMode ?? this.selectedDisplayMode,
      unselectedDisplayMode:
          unselectedDisplayMode ?? this.unselectedDisplayMode,
      selectedGradient: selectedGradient ?? this.selectedGradient,
      unselectedGradient: unselectedGradient ?? this.unselectedGradient,
      badge: badge ?? this.badge,
      iconSize: iconSize ?? this.iconSize,
      selectedIconSize: selectedIconSize ?? this.selectedIconSize,
      labelPosition: labelPosition ?? this.labelPosition,
      indicatorStyle: indicatorStyle ?? this.indicatorStyle,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      enableHaptics: enableHaptics ?? this.enableHaptics,
      tooltip: tooltip ?? this.tooltip,
      glassEffect: glassEffect ?? this.glassEffect,
    );
  }
}

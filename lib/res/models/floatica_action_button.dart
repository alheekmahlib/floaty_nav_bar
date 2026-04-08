import 'package:flutter/material.dart';

/// A model class for customizing a floating action button within a navigation bar.
///
/// The [FloaticaActionButton] allows you to specify a widget, action (onTap),
/// size, background color, and foreground color for a floating action button.
class FloaticaActionButton {
  /// The widget displayed inside the floating action button.
  ///
  /// This can be any widget, such as an [Icon], [Text], or custom widget.
  final Widget icon;

  /// The callback function that is invoked when the button is pressed.
  ///
  /// This is required to define the action when the floating button is tapped.
  final VoidCallback onTap;

  /// The size of the floating action button.
  ///
  /// Defaults to 50. Can be customized by providing a different value.
  final double? size;

  /// The background color of the floating action button.
  ///
  /// If not specified, the theme's primary color is used.
  final Color? backgroundColor;

  /// The foreground color of the floating action button widget.
  ///
  /// This typically sets the color of the widget inside the button.
  /// If not provided, it defaults to a color contrasting with the background.
  final Color? foregroundColor;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The color to use for filling the button when the button has input focus.
  ///
  /// In Material3, defaults to [ColorScheme.onPrimaryContainer] with opacity 0.1.
  /// In Material 2, it defaults to [ThemeData.focusColor] for the current theme.
  final Color? focusColor;

  /// The color to use for filling the button when the button has a pointer
  /// hovering over it.
  ///
  /// Defaults to [ThemeData.hoverColor] for the current theme in Material 2. In
  /// Material 3, defaults to [ColorScheme.onPrimaryContainer] with opacity 0.08.
  final Color? hoverColor;

  /// The splash color for this [FloatingActionButton]'s [InkWell].
  ///
  /// If null, [FloatingActionButtonThemeData.splashColor] is used, if that is
  /// null, [ThemeData.splashColor] is used in Material 2; [ColorScheme.onPrimaryContainer]
  /// with opacity 0.1 is used in Material 3.
  final Color? splashColor;

  /// The tag to apply to the button's [Hero] widget.
  ///
  /// Defaults to a tag that matches other floating action buttons.
  ///
  /// Set this to null explicitly if you don't want the floating action button to
  /// have a hero tag.
  ///
  /// If this is not explicitly set, then there can only be one
  /// [FloatingActionButton] per route (that is, per screen), since otherwise
  /// there would be a tag conflict (multiple heroes on one route can't have the
  /// same tag). The Material Design specification recommends only using one
  /// floating action button per screen.
  final Object? heroTag;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [WidgetStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// Controls the size of this button.
  ///
  /// By default, floating action buttons are non-mini and have a height and
  /// width of 56.0 logical pixels. Mini floating action buttons have a height
  /// and width of 40.0 logical pixels with a layout width and height of 48.0
  /// logical pixels. (The extra 4 pixels of padding on each side are added as a
  /// result of the floating action button having [MaterialTapTargetSize.padded]
  /// set on the underlying [RawMaterialButton.materialTapTargetSize].)
  final bool mini;

  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// True if this is an "extended" floating action button.
  ///
  /// Typically "extended" buttons have a [StadiumBorder] [shape]
  /// and have been created with the [FloatingActionButton.extended]
  /// constructor.
  ///
  /// The [Scaffold] animates the appearance of ordinary floating
  /// action buttons with scale and rotation transitions. Extended
  /// floating action buttons are scaled and faded in.
  final bool isExtended;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// If null, [FloatingActionButtonThemeData.enableFeedback] is used.
  /// If both are null, then default value is true.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The spacing between the icon and the label for an extended
  /// [FloatingActionButton].
  ///
  /// If null, [FloatingActionButtonThemeData.extendedIconLabelSpacing] is used.
  /// If that is also null, the default is 8.0.
  final double? extendedIconLabelSpacing;

  /// The padding for an extended [FloatingActionButton]'s content.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedPadding] is used. If that
  /// is also null, the default is
  /// `EdgeInsetsDirectional.only(start: 16.0, end: 20.0)` if an icon is
  /// provided, and `EdgeInsetsDirectional.only(start: 20.0, end: 20.0)` if not.
  final EdgeInsetsGeometry? extendedPadding;

  /// The text style for an extended [FloatingActionButton]'s label.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedTextStyle] is used. If
  /// that is also null, then [TextTheme.labelLarge] with a letter spacing of 1.2
  /// is used.
  final TextStyle? extendedTextStyle;

  /// Creates a [FloaticaActionButton] with the given widget, onTap, and optional
  /// customization options for size, background color, and foreground color.
  ///
  /// The [icon] can be any widget (such as [Icon] or [Text]) to provide flexibility.
  FloaticaActionButton({
    required this.icon,
    required this.onTap,
    this.size = 50,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
    this.tooltip,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.mouseCursor,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.isExtended = false,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.enableFeedback,
    this.extendedIconLabelSpacing,
    this.extendedPadding,
    this.extendedTextStyle,
  });

  /// Returns a copy of this [FloaticaActionButton] with the option to modify any
  /// of the properties.
  ///
  /// If any parameter is not specified, the current value from the original
  /// object is retained.
  FloaticaActionButton copyWith({
    Widget? icon,
    VoidCallback? onTap,
    double? size,
    Color? backgroundColor,
    Color? foregroundColor,
    Object? heroTag,
    String? tooltip,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
    MouseCursor? mouseCursor,
    bool? mini,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool? isExtended,
    FocusNode? focusNode,
    bool? autofocus,
    MaterialTapTargetSize? materialTapTargetSize,
    bool? enableFeedback,
    double? extendedIconLabelSpacing,
    EdgeInsetsGeometry? extendedPadding,
    TextStyle? extendedTextStyle,
  }) {
    return FloaticaActionButton(
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      heroTag: heroTag ?? this.heroTag,
      tooltip: tooltip ?? this.tooltip,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      splashColor: splashColor ?? this.splashColor,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      mini: mini ?? this.mini,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      isExtended: isExtended ?? this.isExtended,
      focusNode: focusNode ?? this.focusNode,
      autofocus: autofocus ?? this.autofocus,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      extendedIconLabelSpacing:
          extendedIconLabelSpacing ?? this.extendedIconLabelSpacing,
      extendedPadding: extendedPadding ?? this.extendedPadding,
      extendedTextStyle: extendedTextStyle ?? this.extendedTextStyle,
    );
  }
}

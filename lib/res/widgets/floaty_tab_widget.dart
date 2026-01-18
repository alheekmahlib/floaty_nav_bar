import 'dart:ui';

import 'package:floaty_nav_bar/res/models/floaty_shape.dart';
import 'package:floaty_nav_bar/res/models/floaty_tab.dart';
import 'package:floaty_nav_bar/res/utils/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that represents a single tab in the floating navigation bar.
///
/// The [FloatyTabWidget] displays an icon and a title, and visually indicates
/// whether it is selected. The widget supports animations for smooth transitions
/// between states.
class FloatyTabWidget extends StatelessWidget {
  /// Creates a [FloatyTabWidget].
  ///
  /// The [floatyTab] parameter is required and provides the data for the tab,
  /// including its icon, title, and selection state.
  ///
  /// The [shape] parameter defines the shape of the tab's decoration and defaults to [CircleShape].
  const FloatyTabWidget({
    super.key,
    required this.floatyTab,
    this.shape = const CircleShape(),
    this.glassEffect,
  });

  /// The data model for the tab, containing its properties.
  final FloatyTab floatyTab;

  /// The shape of the tab's decoration, which determines its visual appearance.
  final FloatyShape shape;

  /// Glassmorphism effect from the parent FloatyNavBar.
  ///
  /// Individual tab's [glassEffect] takes precedence over this.
  final FloatyGlassEffect? glassEffect;

  /// Gets the effective glass effect (tab-level overrides nav-bar level).
  FloatyGlassEffect? get _effectiveGlassEffect {
    return floatyTab.glassEffect ?? glassEffect;
  }

  /// Gets the current display mode based on selection state.
  FloatyTabDisplayMode get _currentDisplayMode {
    return floatyTab.isSelected
        ? floatyTab.selectedDisplayMode
        : floatyTab.unselectedDisplayMode;
  }

  /// Determines if the icon should be shown based on the current display mode.
  bool get _shouldShowIcon {
    switch (_currentDisplayMode) {
      case FloatyTabDisplayMode.iconOnly:
      case FloatyTabDisplayMode.iconAndTitle:
        return true;
      case FloatyTabDisplayMode.titleOnly:
        return false;
    }
  }

  /// Determines if the title should be shown based on the current display mode.
  bool get _shouldShowTitle {
    switch (_currentDisplayMode) {
      case FloatyTabDisplayMode.iconOnly:
        return false;
      case FloatyTabDisplayMode.titleOnly:
      case FloatyTabDisplayMode.iconAndTitle:
        return true;
    }
  }

  /// Determines the title opacity based on the current display mode.
  double get _titleOpacity {
    switch (_currentDisplayMode) {
      case FloatyTabDisplayMode.iconOnly:
        return 0.0;
      case FloatyTabDisplayMode.titleOnly:
      case FloatyTabDisplayMode.iconAndTitle:
        return 1.0;
    }
  }

  /// Gets the animation duration (custom or default).
  Duration _getAnimationDuration(BuildContext context) {
    return floatyTab.animationDuration ?? context.mediumDuration;
  }

  /// Gets the animation curve (custom or default).
  Curve _getAnimationCurve() {
    return floatyTab.animationCurve ?? Curves.easeInOut;
  }

  /// Gets the current icon size based on selection state.
  double get _currentIconSize {
    return floatyTab.isSelected
        ? floatyTab.selectedIconSize
        : floatyTab.iconSize;
  }

  /// Handles the tap with optional haptic feedback.
  void _handleTap() {
    if (floatyTab.enableHaptics) {
      HapticFeedback.lightImpact();
    }
    floatyTab.onTap();
  }

  /// Builds the decoration based on indicator style and glass effect.
  Decoration? _buildDecoration(BuildContext context) {
    final isSelected = floatyTab.isSelected;
    final indicatorStyle = floatyTab.indicatorStyle;

    // For non-background indicator styles, don't fill the background when selected
    if (indicatorStyle != FloatyIndicatorStyle.background &&
        indicatorStyle != FloatyIndicatorStyle.none) {
      return ShapeDecoration(
        color: floatyTab.unselectedColor ?? context.surfaceColor,
        shape: _buildShapeBorder(context),
      );
    }

    // Glass effect takes precedence
    if (_effectiveGlassEffect != null) {
      return null; // Glass effect is handled separately with ClipRRect + BackdropFilter
    }

    // Gradient takes precedence over solid color
    final gradient =
        isSelected ? floatyTab.selectedGradient : floatyTab.unselectedGradient;

    if (gradient != null) {
      return ShapeDecoration(
        gradient: gradient,
        shape: _buildShapeBorder(context),
      );
    }

    // Default solid color
    return ShapeDecoration(
      color: isSelected
          ? floatyTab.selectedColor ?? context.primaryColor
          : floatyTab.unselectedColor ?? context.surfaceColor,
      shape: _buildShapeBorder(context),
    );
  }

  /// Builds the shape border with optional border styling.
  ShapeBorder _buildShapeBorder(BuildContext context) {
    if (floatyTab.borderColor != null && floatyTab.borderWidth != null) {
      // Create a bordered version of the shape
      if (shape is CircleShape) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular((shape as CircleShape).radius),
          side: BorderSide(
            color: floatyTab.borderColor!,
            width: floatyTab.borderWidth!,
          ),
        );
      } else if (shape is RectangleShape) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular((shape as RectangleShape).radius),
          side: BorderSide(
            color: floatyTab.borderColor!,
            width: floatyTab.borderWidth!,
          ),
        );
      } else if (shape is SquircleShape) {
        return ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular((shape as SquircleShape).radius),
          side: BorderSide(
            color: floatyTab.borderColor!,
            width: floatyTab.borderWidth!,
          ),
        );
      }
    }
    return shape.shapeBorder;
  }

  /// Builds the icon widget with badge support.
  Widget _buildIconWidget(BuildContext context) {
    final iconWidget = Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
          size: _currentIconSize,
          color: floatyTab.isSelected
              ? context.onPrimaryColor
              : context.onSurfaceColor,
        ),
      ),
      child: floatyTab.icon,
    );

    // Add badge if provided
    if (floatyTab.badge != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          iconWidget,
          Positioned(
            right: -4,
            top: -4,
            child: floatyTab.badge!,
          ),
        ],
      );
    }

    return iconWidget;
  }

  /// Builds the title widget.
  Widget _buildTitleWidget(BuildContext context) {
    return Text(
      floatyTab.title,
      style: floatyTab.titleStyle ??
          TextStyle(
            color: floatyTab.isSelected
                ? context.onPrimaryColor
                : context.onSurfaceColor,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  /// Builds the indicator widget (dot or underline).
  Widget _buildIndicator(BuildContext context) {
    final indicatorColor = floatyTab.indicatorColor ??
        floatyTab.selectedColor ??
        context.primaryColor;

    switch (floatyTab.indicatorStyle) {
      case FloatyIndicatorStyle.dot:
        return AnimatedContainer(
          duration: _getAnimationDuration(context),
          curve: _getAnimationCurve(),
          margin: const EdgeInsets.only(top: 4),
          width: floatyTab.isSelected ? 6 : 0,
          height: floatyTab.isSelected ? 6 : 0,
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
          ),
        );
      case FloatyIndicatorStyle.underline:
        return AnimatedContainer(
          duration: _getAnimationDuration(context),
          curve: _getAnimationCurve(),
          margin: const EdgeInsets.only(top: 4),
          width: floatyTab.isSelected ? 20 : 0,
          height: 3,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      case FloatyIndicatorStyle.background:
      case FloatyIndicatorStyle.none:
        return const SizedBox.shrink();
    }
  }

  /// Builds the content layout based on label position.
  Widget _buildContent(BuildContext context) {
    final iconWidget = _shouldShowIcon
        ? AnimatedContainer(
            duration: _getAnimationDuration(context),
            curve: _getAnimationCurve(),
            child: _buildIconWidget(context),
          )
        : const SizedBox.shrink();

    final titleWidget = AnimatedOpacity(
      opacity: _titleOpacity,
      duration:
          _getAnimationDuration(context) + const Duration(milliseconds: 200),
      child: AnimatedSize(
        duration:
            _getAnimationDuration(context) + const Duration(milliseconds: 200),
        curve: _getAnimationCurve(),
        child: !_shouldShowTitle
            ? const SizedBox.shrink()
            : Padding(
                padding: floatyTab.labelPosition == FloatyLabelPosition.right
                    ? EdgeInsetsDirectional.only(start: _shouldShowIcon ? 6 : 0)
                    : const EdgeInsets.only(top: 4),
                child: _buildTitleWidget(context),
              ),
      ),
    );

    final indicator = _buildIndicator(context);

    if (floatyTab.labelPosition == FloatyLabelPosition.bottom) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          titleWidget,
          indicator,
        ],
      );
    }

    // Default: right position
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            titleWidget,
          ],
        ),
        indicator,
      ],
    );
  }

  /// Wraps the content with glassmorphism effect if configured.
  Widget _wrapWithGlassEffect(BuildContext context, Widget child) {
    if (_effectiveGlassEffect == null) return child;

    final glassEffect = _effectiveGlassEffect!;
    final isSelected = floatyTab.isSelected;

    final borderRadius = BorderRadius.circular(
      shape is CircleShape
          ? (shape as CircleShape).radius
          : shape is RectangleShape
              ? (shape as RectangleShape).radius
              : (shape as SquircleShape).radius,
    );

    // When not selected, show transparent background (no glass effect)
    if (!isSelected) {
      return Container(
        decoration: BoxDecoration(
          color: floatyTab.unselectedColor ?? Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: child,
      );
    }

    // When selected, apply glass effect with optional gradient
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: glassEffect.blur * 0.5,
          sigmaY: glassEffect.blur * 0.5,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: floatyTab.selectedGradient ?? glassEffect.gradient,
            color: (floatyTab.selectedGradient == null &&
                    glassEffect.gradient == null)
                ? (floatyTab.selectedColor ?? context.primaryColor)
                    .withValues(alpha: 0.3)
                : null,
            borderRadius: borderRadius,
            border:
                floatyTab.borderColor != null && floatyTab.borderWidth != null
                    ? Border.all(
                        color: floatyTab.borderColor!,
                        width: floatyTab.borderWidth!,
                      )
                    : null,
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tabContent = AnimatedContainer(
      duration: _getAnimationDuration(context),
      curve: _getAnimationCurve(),
      padding: EdgeInsets.symmetric(
        horizontal: floatyTab.isSelected ? 14 : 18,
        vertical:
            floatyTab.labelPosition == FloatyLabelPosition.bottom ? 8 : 10,
      ),
      decoration: _buildDecoration(context),
      child: _buildContent(context),
    );

    // Apply glass effect if configured
    if (_effectiveGlassEffect != null) {
      tabContent = _wrapWithGlassEffect(
        context,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: floatyTab.isSelected ? 14 : 18,
            vertical:
                floatyTab.labelPosition == FloatyLabelPosition.bottom ? 8 : 10,
          ),
          child: _buildContent(context),
        ),
      );
    }

    // Wrap with tooltip if provided
    if (floatyTab.tooltip != null) {
      tabContent = Tooltip(
        message: floatyTab.tooltip!,
        child: tabContent,
      );
    }

    return CupertinoButton(
      onPressed: _handleTap,
      padding: EdgeInsets.zero,
      focusColor: floatyTab.selectedColor ?? context.primaryColor,
      child: tabContent,
    );
  }
}

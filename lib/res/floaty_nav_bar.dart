import 'dart:ui';

import 'package:floaty_nav_bar/res/models/floaty_action_button.dart';
import 'package:floaty_nav_bar/res/models/floaty_shape.dart';
import 'package:floaty_nav_bar/res/models/floaty_tab.dart';
import 'package:floaty_nav_bar/res/utils/context_extension.dart';
import 'package:floaty_nav_bar/res/widgets/floaty_tab_widget.dart';
import 'package:floaty_nav_bar/res/widgets/gap_box.dart';
import 'package:flutter/material.dart';

/// A customizable floating navigation bar that displays tabs and an action button.
///
/// The [FloatyNavBar] widget allows users to navigate between tabs while providing
/// an action button that can perform a specific action related to the selected tab.
/// It supports custom shapes, styles, and animations.
class FloatyNavBar extends StatefulWidget {
  /// Creates a [FloatyNavBar].
  ///
  /// The [tabs] parameter is required and provides the list of tabs to display in
  /// the navigation bar. The [selectedTab] parameter specifies the index of the
  /// currently selected tab.
  ///
  /// The following parameters are optional:
  /// - [margin]: The margin around the navigation bar.
  /// - [height]: The height of the navigation bar. Defaults to 60.
  /// - [gap]: The gap between the tab bar and the action button. Defaults to 16.
  /// - [backgroundColor]: The background color of the navigation bar.
  /// - [boxShadow]: The shadow effect applied to the navigation bar.
  /// - [shape]: The shape of the navigation bar. Defaults to [CircleShape].
  const FloatyNavBar({
    super.key,
    required this.tabs,
    required this.selectedTab,
    this.margin = const EdgeInsetsDirectional.symmetric(vertical: 16),
    this.height = 60,
    this.gap = 16,
    this.backgroundColor,
    this.boxShadow,
    this.shape = const CircleShape(),
    this.glassEffect,
  });

  /// The list of tabs to be displayed in the navigation bar.
  final List<FloatyTab> tabs;

  /// The index of the currently selected tab.
  final int selectedTab;

  /// The height of the navigation bar.
  final double height;

  /// The gap between the tab bar and the action button.
  final double gap;

  /// The margin around the navigation bar.
  final EdgeInsetsGeometry? margin;

  /// The background color of the navigation bar.
  final Color? backgroundColor;

  /// The shadow effect applied to the navigation bar.
  final List<BoxShadow>? boxShadow;

  /// The shape of the navigation bar.
  ///
  /// The default shape is [CircleShape].
  ///
  /// Subclasses include:
  /// - [CircleShape]: A circular shape with rounded corners.
  /// - [RectangleShape]: A rectangular shape with customizable corner radius.
  /// - [SquircleShape]: A squircle shape with a continuous curve for the border.
  ///
  /// You can create custom shapes by extending the [FloatyShape] class.
  final FloatyShape shape;

  /// Glassmorphism effect configuration applied to all tabs.
  ///
  /// If provided, applies a glass-like blur effect to all tab backgrounds.
  /// Individual tabs can override this with their own [glassEffect] property.
  final FloatyGlassEffect? glassEffect;

  @override
  State<FloatyNavBar> createState() => _FloatyNavBarState();
}

class _FloatyNavBarState extends State<FloatyNavBar> {
  late FloatyActionButton? _floatyStyle;

  @override
  void initState() {
    super.initState();
    // Initialize the action button style based on the selected tab.
    _floatyStyle = widget.tabs[widget.selectedTab].floatyActionButton;
  }

  @override
  void didUpdateWidget(covariant FloatyNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the action button style if the selected tab has changed.
    if (oldWidget.selectedTab != widget.selectedTab) {
      setState(() {
        _floatyStyle = widget.tabs[widget.selectedTab].floatyActionButton;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.height,
        margin: widget.margin,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: _buildNavBarContainer(context),
            ),
            AnimatedSize(
              duration: context.fastDuration,
              child: _floatyStyle == null
                  ? const GapBox()
                  : GapBox(gap: widget.gap),
            ),
            AnimatedSize(
              duration: context.mediumDuration,
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              child: SizedBox(
                height: _floatyStyle?.size ?? 0,
                width: _floatyStyle?.size ?? 0,
                child: _buildFloatingActionButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the FloatingActionButton with optional glass effect.
  Widget _buildFloatingActionButton(BuildContext context) {
    if (_floatyStyle == null) return const SizedBox.shrink();

    final fabContent = AnimatedSwitcher(
      duration: context.mediumDuration,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: _floatyStyle?.icon != null
          ? KeyedSubtree(
              key: ValueKey(_floatyStyle!.icon.hashCode),
              child: _floatyStyle!.icon,
            )
          : const SizedBox.shrink(),
    );

    // Apply glass effect if configured
    if (widget.glassEffect != null) {
      final glassEffect = widget.glassEffect!;
      final borderRadius = BorderRadius.circular(
        widget.shape is CircleShape
            ? (widget.shape as CircleShape).radius
            : widget.shape is RectangleShape
                ? (widget.shape as RectangleShape).radius
                : (widget.shape as SquircleShape).radius,
      );

      return GestureDetector(
        onTap: _floatyStyle?.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: glassEffect.enableShadow
                ? [
                    BoxShadow(
                      color: glassEffect.shadowColor ??
                          Colors.black.withValues(alpha: 0.25),
                      blurRadius: glassEffect.shadowBlur * 0.5,
                      spreadRadius: glassEffect.shadowSpread * 0.5,
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: glassEffect.blur * 0.5,
                sigmaY: glassEffect.blur * 0.5,
              ),
              child: Container(
                width: _floatyStyle?.size ?? 56,
                height: _floatyStyle?.size ?? 56,
                decoration: BoxDecoration(
                  gradient: glassEffect.gradient,
                  color: glassEffect.gradient == null
                      ? (_floatyStyle?.backgroundColor ?? context.primaryColor)
                          .withValues(alpha: 0.3)
                      : null,
                  borderRadius: borderRadius,
                  border: glassEffect.borderWidth > 0
                      ? Border.all(
                          color: glassEffect.borderColor ??
                              Colors.white.withValues(alpha: 0.2),
                          width: glassEffect.borderWidth,
                        )
                      : null,
                ),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color: _floatyStyle?.foregroundColor ??
                          context.onPrimaryColor,
                    ),
                    child: fabContent,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Default FloatingActionButton without glass effect
    return FloatingActionButton(
      shape: widget.shape.shapeBorder,
      backgroundColor: _floatyStyle?.backgroundColor ?? context.primaryColor,
      foregroundColor: _floatyStyle?.foregroundColor ?? context.onPrimaryColor,
      onPressed: _floatyStyle?.onTap,
      heroTag: _floatyStyle?.heroTag,
      autofocus: _floatyStyle?.autofocus ?? false,
      clipBehavior: _floatyStyle?.clipBehavior ?? Clip.none,
      enableFeedback: _floatyStyle?.enableFeedback ?? true,
      focusColor: _floatyStyle?.focusColor ?? context.primaryColor,
      hoverColor: _floatyStyle?.hoverColor ?? context.primaryColor,
      splashColor: _floatyStyle?.splashColor ?? context.primaryColor,
      tooltip: _floatyStyle?.tooltip,
      mini: _floatyStyle?.mini ?? false,
      focusNode: _floatyStyle?.focusNode,
      isExtended: _floatyStyle?.isExtended ?? false,
      key: ValueKey(_floatyStyle?.icon.hashCode),
      materialTapTargetSize: _floatyStyle?.materialTapTargetSize,
      mouseCursor: _floatyStyle?.mouseCursor,
      child: fabContent,
    );
  }

  /// Builds the navigation bar container with optional glass effect.
  Widget _buildNavBarContainer(BuildContext context) {
    final tabsRow = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.tabs.map((tab) {
        return FloatyTabWidget(
          floatyTab: tab,
          shape: widget.shape,
          glassEffect: widget.glassEffect,
        );
      }).toList(),
    );

    // Apply glass effect if configured
    if (widget.glassEffect != null) {
      final glassEffect = widget.glassEffect!;
      final borderRadius = BorderRadius.circular(
        widget.shape is CircleShape
            ? (widget.shape as CircleShape).radius
            : widget.shape is RectangleShape
                ? (widget.shape as RectangleShape).radius
                : (widget.shape as SquircleShape).radius,
      );

      return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: glassEffect.enableShadow
              ? [
                  BoxShadow(
                    color: glassEffect.shadowColor ??
                        Colors.black.withValues(alpha: 0.25),
                    blurRadius: glassEffect.shadowBlur,
                    spreadRadius: glassEffect.shadowSpread,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: glassEffect.blur,
              sigmaY: glassEffect.blur,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: glassEffect.gradient,
                color: glassEffect.gradient == null
                    ? (glassEffect.tintColor ?? Colors.black)
                        .withValues(alpha: glassEffect.opacity)
                    : null,
                borderRadius: borderRadius,
                border: glassEffect.borderWidth > 0
                    ? Border.all(
                        color: glassEffect.borderColor ??
                            Colors.white.withValues(alpha: 0.2),
                        width: glassEffect.borderWidth,
                      )
                    : null,
              ),
              child: tabsRow,
            ),
          ),
        ),
      );
    }

    // Default container without glass effect
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: widget.backgroundColor ?? context.surfaceColor,
        shape: widget.shape.shapeBorder,
        shadows: widget.boxShadow ?? [context.boxShadow],
      ),
      child: tabsRow,
    );
  }
}

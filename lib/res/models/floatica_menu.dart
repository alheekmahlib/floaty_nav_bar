import 'package:floatica/res/models/floatica_menu_controller.dart';
import 'package:floatica/res/models/floatica_tab.dart';
import 'package:flutter/material.dart';

/// Configuration for an optional expandable menu in the [FloaticaNavBar].
///
/// When provided, the menu renders as a tab in the navigation bar. Tapping it
/// expands the nav bar upward to reveal a custom [child] widget above the tabs.
class FloaticaMenu {
  /// Creates a [FloaticaMenu] configuration.
  const FloaticaMenu({
    required this.child,
    required this.icon,
    this.height,
    this.title = 'More',
    this.titleStyle,
    this.animationDuration,
    this.animationCurve,
    this.selectedColor,
    this.unselectedColor,
    this.selectedDisplayMode = FloaticaTabDisplayMode.iconAndTitle,
    this.unselectedDisplayMode = FloaticaTabDisplayMode.iconOnly,
    this.iconSize = 22.0,
    this.selectedIconSize = 24.0,
    this.labelPosition = FloaticaLabelPosition.right,
    this.margin = const EdgeInsets.all(4),
    this.onMenuToggle,
    this.barrierColor = const Color(0x40000000),
    this.barrierBlur = 4.0,
    this.controller,
  });

  /// The widget displayed inside the expanded menu area.
  ///
  /// You have full control over the content — use any layout you want
  /// (e.g. [GridView], [Wrap], [Column], custom widgets).
  final Widget child;

  /// The height of the expanded menu area.
  ///
  /// If not provided, the menu will size itself based on its [child] widget.
  final double? height;

  /// The icon shown on the menu tab in the navigation bar.
  final Widget icon;

  /// The title label for the menu tab.
  ///
  /// Defaults to `'More'`.
  final String title;

  /// Custom text style for the menu tab title.
  final TextStyle? titleStyle;

  /// The duration of the expand/collapse animation.
  ///
  /// Defaults to 300ms if not provided.
  final Duration? animationDuration;

  /// The curve of the expand/collapse animation.
  ///
  /// Defaults to [Curves.easeOutCubic] if not provided.
  final Curve? animationCurve;

  /// The color of the menu tab when selected (menu is open).
  final Color? selectedColor;

  /// The color of the menu tab when unselected (menu is closed).
  final Color? unselectedColor;

  /// Display mode when the menu tab is selected (menu is open).
  final FloaticaTabDisplayMode selectedDisplayMode;

  /// Display mode when the menu tab is not selected (menu is closed).
  final FloaticaTabDisplayMode unselectedDisplayMode;

  /// The size of the icon when the menu tab is not selected.
  final double iconSize;

  /// The size of the icon when the menu tab is selected.
  final double selectedIconSize;

  /// The position of the label relative to the icon.
  final FloaticaLabelPosition labelPosition;

  /// The margin around the menu tab.
  ///
  /// Defaults to `EdgeInsets.all(4)`.
  final EdgeInsetsGeometry margin;

  /// Called when the menu opens or closes.
  ///
  /// The [bool] parameter is `true` when the menu opens and `false` when it closes.
  final ValueChanged<bool>? onMenuToggle;

  /// The color of the barrier overlay shown behind the nav bar when the menu is open.
  ///
  /// Set to [Colors.transparent] and [barrierBlur] to `0` to disable the barrier.
  /// Defaults to black with ~25% opacity.
  final Color barrierColor;

  /// The blur intensity of the barrier overlay shown behind the nav bar.
  ///
  /// Set to `0` and [barrierColor] to [Colors.transparent] to disable the barrier.
  /// Defaults to `4.0`.
  final double barrierBlur;

  /// An optional controller to programmatically open, close, or toggle the menu.
  ///
  /// ```dart
  /// final controller = FloatyMenuController();
  /// // ...
  /// controller.open();
  /// controller.close();
  /// controller.toggle();
  /// ```
  final FloaticaMenuController? controller;
}

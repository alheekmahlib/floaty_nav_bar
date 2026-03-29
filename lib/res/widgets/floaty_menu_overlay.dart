import 'package:floaty_nav_bar/res/models/floaty_menu.dart';
import 'package:flutter/material.dart';

/// An animated overlay that displays a [FloatyMenu]'s child widget.
///
/// Opens with a scale + fade animation from the bottom.
class FloatyMenuOverlay extends StatelessWidget {
  const FloatyMenuOverlay({
    super.key,
    required this.menu,
    required this.animation,
    required this.onDismiss,
  });

  /// The menu configuration.
  final FloatyMenu menu;

  /// The animation driving the overlay's appearance.
  final Animation<double> animation;

  /// Called when the overlay should be dismissed.
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final curve = menu.animationCurve ?? Curves.easeOutCubic;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: curve.flipped,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: menu.height,
          child: menu.child,
        ),
      ),
    );
  }
}

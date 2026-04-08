import 'package:flutter/foundation.dart';

/// A controller for programmatically opening and closing the [FloaticaMenu].
///
/// Attach this to a [FloaticaMenu] via the [FloaticaMenu.controller] property,
/// then call [open], [close], or [toggle] to control the menu state.
///
/// ```dart
/// final _menuController = FloaticaMenuController();
///
/// // Open the menu
/// _menuController.open();
///
/// // Close the menu
/// _menuController.close();
///
/// // Toggle
/// _menuController.toggle();
/// ```
///
/// Remember to call [dispose] when the controller is no longer needed.
class FloaticaMenuController extends ChangeNotifier {
  FloaticaMenuAction? _pendingAction;

  /// Whether the menu is currently open.
  bool get isOpen => _isOpen;
  bool _isOpen = false;

  /// Opens the menu.
  void open() {
    if (_isOpen) return;
    _pendingAction = FloaticaMenuAction.open;
    notifyListeners();
  }

  /// Closes the menu.
  void close() {
    if (!_isOpen) return;
    _pendingAction = FloaticaMenuAction.close;
    notifyListeners();
  }

  /// Toggles the menu open/closed.
  void toggle() {
    _pendingAction = FloaticaMenuAction.toggle;
    notifyListeners();
  }

  /// Consumes the pending action. Used internally by [FloatyNavBar].
  FloaticaMenuAction? consumeAction() {
    final action = _pendingAction;
    _pendingAction = null;
    return action;
  }

  /// Updates the internal open state. Used internally by [FloatyNavBar].
  void updateIsOpen(bool value) {
    if (_isOpen == value) return;
    _isOpen = value;
    notifyListeners();
  }
}

/// Actions that can be performed on a [FloaticaMenuController].
///
/// Used internally by the nav bar to process controller commands.
enum FloaticaMenuAction { open, close, toggle }

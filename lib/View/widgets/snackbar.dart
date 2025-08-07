import 'package:flutter/material.dart';
import 'dart:async';

/// Manages the display and lifecycle of custom snackbars.
/// It ensures that a maximum of 3 snackbars are visible at any time.
class CustomSnackbarManager {
  // A list to keep track of the currently active snackbars.
  static final List<_ActiveSnackbar> _activeSnackbars = [];
  // The maximum number of snackbars that can be displayed simultaneously.
  static const int _maxSnackbars = 3;

  /// Displays a custom error snackbar.
  /// If the maximum number of snackbars is already displayed, it removes the oldest one.
  static void showError(BuildContext context, String message) {
    // If we've reached the max number of snackbars, remove the oldest one.
    if (_activeSnackbars.length >= _maxSnackbars) {
      final oldestSnackbar = _activeSnackbars.removeAt(0);
      oldestSnackbar.remove();
    }

    // We need a reference to the OverlayEntry to manage its lifecycle.
    OverlayEntry? entry;

    // The callback to be executed when the snackbar is dismissed.
    void onDismissed() {
      _activeSnackbars.removeWhere((s) => s.entry == entry);
      if (entry?.mounted ?? false) {
        entry?.remove();
      }
      // Trigger a rebuild of the overlay to update the positions and scales of remaining snackbars.
      Overlay.of(context).setState(() {});
    }

    entry = OverlayEntry(
      builder: (ctx) => _CustomSnackbarWidget(
        entry: entry!,
        message: message,
        onDismissed: onDismissed,
      ),
    );

    _activeSnackbars.add(_ActiveSnackbar(entry: entry));
    // We call setState to animate the other snackbars when a new one is added.
    Overlay.of(context).insert(entry);
    Overlay.of(context).setState(() {});
  }
}

/// A helper class to hold a reference to an active OverlayEntry.
class _ActiveSnackbar {
  final OverlayEntry entry;

  _ActiveSnackbar({required this.entry});

  /// Removes the snackbar's OverlayEntry from the overlay.
  void remove() {
    if (entry.mounted) {
      entry.remove();
    }
  }
}

/// The actual widget that displays the snackbar content and handles animations.
class _CustomSnackbarWidget extends StatefulWidget {
  final OverlayEntry entry;
  final String message;
  final VoidCallback onDismissed;

  const _CustomSnackbarWidget({
    required this.entry,
    required this.message,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  State<_CustomSnackbarWidget> createState() => _CustomSnackbarWidgetState();
}

class _CustomSnackbarWidgetState extends State<_CustomSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2.0), // Start further down for a better effect
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _slideController.forward();

    _dismissTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _slideController.reverse().then((_) {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeSnackbars = CustomSnackbarManager._activeSnackbars;
    final index = activeSnackbars.indexWhere((s) => s.entry == widget.entry);
    final isTopmost = index == activeSnackbars.length - 1;

    if (index == -1) {
      return const SizedBox.shrink();
    }

    // Calculate properties based on the snackbar's position in the stack
    final scale = 1.0 - (activeSnackbars.length - 1 - index) * 0.05;
    final bottomOffset = 10.0 + (index * 10.0);
    final horizontalPadding = 16.0 + (activeSnackbars.length - 1 - index) * 10.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      bottom: bottomOffset,
      left: horizontalPadding,
      right: horizontalPadding,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: scale,
        child: SlideTransition(
          position: _slideAnimation,
          child: isTopmost ? _buildSnackbarContent() : IgnorePointer(child: _buildSnackbarContent()),
        ),
      ),
    );
  }

  Widget _buildSnackbarContent() {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

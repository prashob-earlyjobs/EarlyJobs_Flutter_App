import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class CustomSnackbarManager extends GetxController {
  // Reactive list of active snackbars (max 3 at a time)
  final RxList<_ActiveSnackbar> _activeSnackbars = <_ActiveSnackbar>[].obs;

  static CustomSnackbarManager get to => Get.find<CustomSnackbarManager>();

  static const int _maxSnackbars = 3;

  void showError(BuildContext context, String message) {
    // If we already have 3, remove the first one
    if (_activeSnackbars.length >= _maxSnackbars) {
      final oldest = _activeSnackbars.removeAt(0);
      oldest.remove();
    }

    OverlayEntry? entry;
    void onDismissed() {
      // Remove from list
      _activeSnackbars.removeWhere((s) => s.entry == entry);
      // Safely remove overlay
      if (entry?.mounted ?? false) {
        entry?.remove();
      }
    }

    entry = OverlayEntry(
      builder: (_) => _CustomSnackbarWidget(
        entry: entry!,
        message: message,
        onDismissed: onDismissed,
      ),
    );

    _activeSnackbars.add(_ActiveSnackbar(entry: entry));
    Overlay.of(context).insert(entry!);
  }

  // Getter for UI access (for rebuilding with Obx)
  List<_ActiveSnackbar> get activeSnackbars => _activeSnackbars;
}

class _ActiveSnackbar {
  final OverlayEntry entry;
  _ActiveSnackbar({required this.entry});

  void remove() {
    if (entry.mounted) {
      entry.remove();
    }
  }
}

// ===== Snackbar Widget =====
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
      begin: const Offset(0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

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
    // Find index reactively
    final manager = CustomSnackbarManager.to;
    final index = manager.activeSnackbars
        .indexWhere((s) => s.entry == widget.entry);

    if (index == -1) return const SizedBox.shrink();

    final isTopmost = index == manager.activeSnackbars.length - 1;
    final scale = 1.0 - (manager.activeSnackbars.length - 1 - index) * 0.05;
    final bottomOffset = 10.0 + (index * 10.0);
    final horizontalPadding =
        16.0 + (manager.activeSnackbars.length - 1 - index) * 10.0;

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
          child: isTopmost
              ? _buildSnackbarContent()
              : IgnorePointer(child: _buildSnackbarContent()),
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

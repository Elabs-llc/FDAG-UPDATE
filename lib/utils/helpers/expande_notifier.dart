import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandNotifier extends StateNotifier<bool> {
  ExpandNotifier() : super(false); // Initially not expanded

  void toggle() {
    state = !state; // Toggle the expansion state
  }
}

// Provider for the ExpandNotifier
final expandProvider = StateNotifierProvider<ExpandNotifier, bool>(
  (ref) => ExpandNotifier(),
);

import 'package:fdag/utils/device/network_notifier.dart';
import 'package:fdag/utils/device/network_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier class that manages connectivity state
class NetworkProvider extends StateNotifier<ConnectionStatus> {
  final NetworkNotifier _networkNotifier;

  NetworkProvider(this._networkNotifier) : super(ConnectionStatus.none) {
    _init();
  }

  // Initialize to check initial connectivity and listen for changes
  Future<void> _init() async {
    // Set the initial state based on current connectivity
    state = await _networkNotifier.checkInitialConnectivity();

    // Listen to connectivity changes
    _networkNotifier.onConnectivityChanged.listen((status) {
      state = status; // Update the state on connectivity change
    });
  }

  // Method to check if the device is connected
  Future<bool> isDeviceConnected() {
    return _networkNotifier.isDeviceConnected();
  }
}

// Riverpod provider for the NetworkProvider
final connectivityProvider =
    StateNotifierProvider<NetworkProvider, ConnectionStatus>(
  (ref) => NetworkProvider(NetworkNotifier()),
);

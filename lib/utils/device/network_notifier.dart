import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fdag/utils/device/network_type.dart';

class NetworkNotifier {
  // Method to check initial connectivity
  Future<ConnectionStatus> checkInitialConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // If the result is a List, handle multiple connections; otherwise, handle single connectivity
    return _getConnectionStatusFromList(connectivityResult);
  }

  // Method to return a bool indicating if the device is connected or not
  Future<bool> isDeviceConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return _getConnectionStatusFromList(connectivityResult) !=
        ConnectionStatus.none;
  }

  // Stream to listen to connectivity changes
  Stream<ConnectionStatus> get onConnectivityChange {
    return Connectivity().onConnectivityChanged.map((result) {
      return _getConnectionStatusFromList(result);
    });
  }

  // Stream to listen to connectivity changes
  Stream<ConnectionStatus> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map((result) {
      // Handle both List<ConnectivityResult> and single ConnectivityResult
      return _getConnectionStatusFromList(result);
    });
  }

  // Private method to map single ConnectivityResult to ConnectionStatus
  ConnectionStatus _getConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      return ConnectionStatus.wifi;
    } else if (result == ConnectivityResult.mobile) {
      return ConnectionStatus.mobile;
    } else {
      return ConnectionStatus.none;
    }
  }

  // Handle multiple connectivity results, prioritizing Wi-Fi over mobile
  ConnectionStatus _getConnectionStatusFromList(
      List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectionStatus.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      return ConnectionStatus.mobile;
    } else {
      return ConnectionStatus.none;
    }
  }
}

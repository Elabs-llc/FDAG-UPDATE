import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/utils/device/device_helper.dart';
import 'package:fdag/utils/logging/logger.dart';

class AppCore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Creates a new user document in the Firestore database.
  ///   - `uid`: The unique identifier of the user.
  ///  - `displayName`: The display name of the user.
  /// - `email`: The email address of the user.
  /// - `photoUrl`: The URL of the user's profile photo.
  Future<void> createUserDocument(String? uid, String? displayName,
      String? email, String? photoUrl, String? provider) async {
    Logger.logLevel = 'INFO';
    try {
      // Await the device info
      final deviceInfo = await DeviceHelper.getDeviceInfo();

      // Pass the resolved device info map to Firestore
      await _firestore.collection('users').doc(uid).set({
        'userFullName': displayName,
        'userEmail': email,
        'photoUrl': photoUrl,
        'lastSeen': DateTime.now(),
        'createdAt': DateTime.now(),
        'signInMethod': provider,
        'device': deviceInfo,
      });
    } catch (e) {
      Logger.info('Error creating user document: $e');
    }
  }

  /// Updates the user's last seen time in the Firestore database.

  Future<void> updateUserLastSeen(String? uid) async {
    Logger.logLevel = 'INFO';
    try {
      await _firestore.collection('users').doc(uid).update({
        'lastSeen': DateTime.now(),
      });
    } catch (e) {
      Logger.info('Error updating user last seen: $e');
    }
  }
}

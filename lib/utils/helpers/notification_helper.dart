import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static void requestNotificationPermission() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('User denied permission');
    }
  }

  Future<void> sendNotificationBasedOnPreferences(String userId) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notification')
        .doc('settings');

    final snapshot = await doc.get();
    if (!snapshot.exists) return;

    final data = snapshot.data();
    bool eventsEnabled = data?['eventsNotifications'] ?? false;
    bool membershipEnabled = data?['membershipNotifications'] ?? false;
    bool newsEnabled = data?['newsNotifications'] ?? false;

    // Send notifications based on preferences
    if (eventsEnabled) {
      // Trigger FCM for events
    }
    if (membershipEnabled) {
      // Trigger FCM for membership updates
    }
    if (newsEnabled) {
      // Trigger FCM for news
    }
  }

  void initializeFirebaseMessagingHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          'Received a foreground message: ${message.notification?.title}');
      // Handle the notification and show it in-app
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification opened: ${message.notification?.title}');
      // Handle navigation or other actions
    });
  }
}

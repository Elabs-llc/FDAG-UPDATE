import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool eventsNotifications = true;
  bool membershipNotifications = true;
  bool newsNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved toggle states
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      eventsNotifications = prefs.getBool('eventsNotifications') ?? true;
      membershipNotifications =
          prefs.getBool('membershipNotifications') ?? true;
      newsNotifications = prefs.getBool('newsNotifications') ?? true;
    });
    _syncWithFirestore(); // Sync preferences from Firestore
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    // Update Firestore
    await _updateFirestoreSettings(key, value);
  }

  Future<void> _syncWithFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notification')
        .doc('settings'); // Nested structure for notification settings

    final snapshot = await doc.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      setState(() {
        eventsNotifications =
            data?['eventsNotifications'] ?? eventsNotifications;
        membershipNotifications =
            data?['membershipNotifications'] ?? membershipNotifications;
        newsNotifications = data?['newsNotifications'] ?? newsNotifications;
      });
    }
  }

  Future<void> _updateFirestoreSettings(String key, bool value) async {
    User? user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notification')
        .doc('settings'); // Nested structure for notification settings

    await doc.set(
      {key: value},
      SetOptions(merge: true), // Merges the new setting with existing data
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSettingsCard(
                  constraints,
                  title: 'Notification Categories',
                  children: [
                    _buildToggleOption(
                      'Events & Workshops',
                      'Get notified about upcoming events',
                      eventsNotifications,
                      (value) {
                        setState(() => eventsNotifications = value);
                        _saveSetting('eventsNotifications', value);
                      },
                    ),
                    const Divider(height: 1),
                    _buildToggleOption(
                      'Membership Updates',
                      'Renewal reminders and membership benefits',
                      membershipNotifications,
                      (value) {
                        setState(() => membershipNotifications = value);
                        _saveSetting('membershipNotifications', value);
                      },
                    ),
                    const Divider(height: 1),
                    _buildToggleOption(
                      'News & Updates',
                      'Industry news and FDAG updates',
                      newsNotifications,
                      (value) {
                        setState(() => newsNotifications = value);
                        _saveSetting('newsNotifications', value);
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BoxConstraints constraints, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleOption(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

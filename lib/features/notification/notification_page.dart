import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _openNotificationSettings(context),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                _buildNotificationCategories(constraints),
                Expanded(
                  child: _buildNotificationsList(constraints),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCategories(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        maxHeight: 60,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildCategoryChip(
            label: 'All',
            isSelected: true,
            onTap: () {},
            constraints: constraints,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            label: 'Events',
            isSelected: false,
            onTap: () {},
            constraints: constraints,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            label: 'Updates',
            isSelected: false,
            onTap: () {},
            constraints: constraints,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required BoxConstraints constraints,
  }) {
    return Material(
      color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.3,
            minWidth: 80,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(BoxConstraints constraints) {
    final notifications = [
      {
        'type': 'event',
        'title': 'Upcoming Fashion Show',
        'message':
            'Join us for the Annual Ghana Fashion Week starting next week.',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'type': 'update',
        'title': 'Membership Renewal',
        'message':
            'Your membership will expire in 30 days. Renew now to continue enjoying benefits.',
        'time': '1 day ago',
        'isRead': true,
      },
      {
        'type': 'event',
        'title': 'Workshop Registration',
        'message':
            'New workshop on sustainable fashion design is now open for registration.',
        'time': '2 days ago',
        'isRead': true,
      },
      // Add more notifications as needed
    ];

    if (notifications.isEmpty) {
      return _buildEmptyState(constraints);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(
          type: notification['type']! as String,
          title: notification['title']! as String,
          message: notification['message']! as String,
          time: notification['time']! as String,
          isRead: notification['isRead'] as bool,
          constraints: constraints,
        );
      },
    );
  }

  Widget _buildNotificationCard({
    required String type,
    required String title,
    required String message,
    required String time,
    required bool isRead,
    required BoxConstraints constraints,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNotificationTap(type),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(type),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'event':
        icon = Icons.event;
        color = Colors.blue;
        break;
      case 'update':
        icon = Icons.notifications;
        color = Colors.orange;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildEmptyState(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: constraints.maxHeight * 0.5,
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll notify you when there\'s something new',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _openNotificationSettings(BuildContext context) {
    // Implement notification settings navigation
    Navigator.pushNamed(context, 'notificationSettings');
  }

  void _handleNotificationTap(String type) {
    // Implement notification tap handling
  }
}

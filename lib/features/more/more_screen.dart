import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  AppWidgets.buildGridMenu(context, constraints),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.buildListSection(
                        title: 'Support',
                        items: [
                          AppWidgets.buildListItem(
                            icon: Icons.headset_mic,
                            title: 'Help Center',
                            onTap: () =>
                                Navigator.pushNamed(context, 'helpCenter'),
                          ),
                          Divider(
                            color: const Color.fromARGB(90, 158, 158, 158),
                            thickness: 1.0,
                          ),
                          AppWidgets.buildListItem(
                            icon: Icons.info,
                            title: 'About FDAG',
                            onTap: () =>
                                Navigator.pushNamed(context, 'aboutPage'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppWidgets.buildListSection(
                        title: 'Settings',
                        items: [
                          AppWidgets.buildListItem(
                            icon: Icons.notifications,
                            title: 'Notifications',
                            onTap: () => Navigator.pushNamed(
                                context, 'notificationSettings'),
                          ),
                          Divider(
                            color: const Color.fromARGB(90, 158, 158, 158),
                            thickness: 1.0,
                          ),
                          AppWidgets.buildListItem(
                            icon: Icons.privacy_tip,
                            title: 'Privacy Policy',
                            onTap: () => {},
                          ),
                          Divider(
                            color: Color.fromARGB(90, 158, 158, 158),
                            thickness: 1.0,
                          ),
                          AppWidgets.buildListItem(
                            icon: Icons.description,
                            title: 'Terms of Service',
                            onTap: () => {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

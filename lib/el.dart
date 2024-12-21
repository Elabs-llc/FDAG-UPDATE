import 'package:fdag/features/more/about_page.dart';
import 'package:fdag/features/more/help_center_page.dart';
import 'package:fdag/features/notification/notification_page.dart';
import 'package:fdag/features/notification/notification_settings.dart';
import 'package:fdag/pages/auth/login.dart';
import 'package:fdag/pages/auth/signup.dart';
import 'package:fdag/pages/home.dart';
import 'package:fdag/pages/screens/all_event_page.dart';
import 'package:fdag/pages/screens/by_laws_page.dart';
import 'package:fdag/pages/screens/founding_members_page.dart';
import 'package:fdag/pages/screens/mission_vision_page.dart';
import 'package:fdag/pages/splash_screen.dart';
import 'package:fdag/utils/theme/theme.dart';
import 'package:flutter/material.dart';

/// The core class of the Elabs application that initializes the app.
///
/// This class extends `StatelessWidget` and serves as the main entry point
/// for the Flutter application. It sets up the `MaterialApp`, including
/// the application's title, themes, and initial home screen.
///
/// The app supports both light and dark themes, which are defined in
/// `ElAppTheme`. The `home` property is set to `SplashScreen`, which
/// is displayed when the app is first launched. The class also defines
/// routes for navigation within the app, including `/home` for the
/// `Home` screen and `/intro` for the `Intro` screen.
class El extends StatelessWidget {
  const El({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FDAG',
      themeMode: ThemeMode.system,
      theme: ElAppTheme.lightTheme,
      darkTheme: ElAppTheme.darkTheme,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => Home(),
        '/login': (contex) => Login(),
        '/signup': (contex) => Signup(),
        '/allEvents': (contex) => AllEventPage(),
        '/byLaws': (contex) => BylawsPage(),
        '/missionVision': (context) => MissionVisionPage(),
        '/founders': (context) => FoundingMembersPage(),
        'helpCenter': (context) => HelpCenterPage(),
        'aboutPage': (context) => AboutPage(),
        'notificationSettings': (context) => NotificationSettings(),
        'notificationPage': (context) => NotificationPage(),
      },
    );
  }
}

import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/pages/auth/login.dart';
import 'package:fdag/pages/home.dart';
import 'package:fdag/pages/intro.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A splash screen displayed initially when the app is launched.
///
/// This screen hides the system status bar and displays an introductory
/// animation or message. The class checks if the user has seen the intro slides
/// using `SharedPreferences`. If the intro slides have not been viewed, the app
/// navigates to the `Intro` screen; otherwise, it moves directly to the
/// authentication check to determine if the user is logged in or needs to go
/// to the login screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Hide the system status bar for the splash screen.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    _navigateToNext();

    // Set the logging level and log the splash screen completion.
    Logger.logLevel = 'INFO';
    Logger.info("Elabs App Log: Splash Screen ended");
  }

  @override
  void dispose() {
    super.dispose();
    // Show the status bar again when the splash screen is disposed.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  /// Determines and navigates to the appropriate next screen after the splash.
  ///
  /// Uses `SharedPreferences` to check if the user has previously seen the
  /// intro slides (`hasSeenIntro`). If `false`, navigates to the `Intro` screen;
  /// if `true`, goes directly to an authentication check screen.
  /// Includes a delay to show the splash screen for a few seconds.
  void _navigateToNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;

    await Future.delayed(Duration(seconds: 6));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          // if (!hasSeenIntro) {
          //   // Navigate to the Intro screen for first-time users.
          //   return Intro(
          //     onIntroComplete: onIntroComplete,
          //   );
          // } else {
          //   // Skip Intro and proceed to authentication check for returning users.
          //   return _buildAuthStream();
          // }

          return _buildAuthStream();
        },
      ),
    );
  }

  /// Navigates to either the `Home` or `Login` screen based on user authentication status.
  ///
  /// Uses a `StreamBuilder` to listen to changes in the user's authentication
  /// state. If a user is authenticated, navigates to the `Home` screen.
  /// Otherwise, directs the user to the `Login` screen.
  void _navigateToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StreamBuilder<User?>(
          stream: _firebaseAuth.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen(); // Optionally show a loading screen here.
            }
            if (snapshot.hasData) {
              User? user = snapshot.data;
              if (user != null) {
                return Home();
              }
              return Login();
            }
            return Login();
          },
        ),
      ),
    );
  }

  /// Constructs a widget that listens to and handles changes in authentication state.
  ///
  /// Displays the `Home` screen if the user is authenticated, or the `Login`
  /// screen if not. Acts as an entry point into the app after splash.
  Widget _buildAuthStream() {
    return StreamBuilder(
      stream: _firebaseAuth.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Displays splash screen if waiting for auth state
        }
        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            return Home(); // Navigates to Home if user is authenticated
          }
          return Login();
        }
        return Login(); // Navigates to Login if no user is authenticated
      },
    );
  }

  // Call this when the intro finishes
  void onIntroComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/images/dag-splash-modern.svg",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.f1,
                  ),
                  Text(
                    'Fashion Designers',
                    style: ElColor.whiteColor,
                  ),
                  SizedBox(
                    height: Sizes.xs,
                  ),
                  Text(
                    'Association of Ghana',
                    style: ElColor.whiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

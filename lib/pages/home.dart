import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/elabs/config.dart';
import 'package:fdag/features/more/more_screen.dart';
import 'package:fdag/pages/el/gallery.dart';
import 'package:fdag/pages/el/home_view.dart';
import 'package:fdag/pages/el/discover_page.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void onIconPressed(int index) {
    setState(() {
      _selectedIndex = index;
      // handle page navigation here
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Listen for auth state changes and navigate based on the user state.
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        // Ensure the widget is still in the tree
        Navigator.pushNamed(context, '/login');
      }
      Logger.logLevel = 'INFO';
      Logger.info("User: ${user?.email}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ElColor.darkBlue,
      //   focusColor: ElColor.darkBlue,
      //   hoverColor: ElColor.darkBlue,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.add,
      //     color: ElColor.textWhite,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 70, // Increased height to fit titles
        color: ElColor.gold,
        shape: const CircularNotchedRectangle(),
        notchMargin: Sizes.f001,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppWidgets.buildNavItem(
              icon: Icons.home,
              label: Config.bottomNavHomeText,
              isSelected: _selectedIndex == 0,
              onTap: () => onIconPressed(0),
            ),
            AppWidgets.buildNavItem(
              icon: Icons.image_rounded,
              label: Config.bottomNavGalleryText,
              isSelected: _selectedIndex == 1,
              onTap: () => onIconPressed(1),
            ),
            SizedBox(width: Sizes.f1), // Spacer for the floating action button
            AppWidgets.buildNavItem(
              icon: Icons.explore,
              label: Config.bottomNavMVText,
              isSelected: _selectedIndex == 2,
              onTap: () => onIconPressed(2),
            ),
            AppWidgets.buildNavItem(
              icon: Icons.menu,
              label: Config.bottomNavByText,
              isSelected: _selectedIndex == 3,
              onTap: () => onIconPressed(3),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            HomeView(),
            Gallery(),
            DiscoverPage(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}

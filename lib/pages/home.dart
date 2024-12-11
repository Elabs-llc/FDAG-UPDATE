import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/elabs/config.dart';
import 'package:fdag/pages/el/by_laws.dart';
import 'package:fdag/pages/el/gallery.dart';
import 'package:fdag/pages/el/home_view.dart';
import 'package:fdag/pages/el/mv.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ElColor.darkBlue,
        focusColor: ElColor.darkBlue,
        hoverColor: ElColor.darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: ElColor.textWhite,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: ElColor.gold,
        shape: const CircularNotchedRectangle(),
        notchMargin: Sizes.f001,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              tooltip: Config.bottomNavHomeText,
              style: ButtonStyle(
                backgroundColor: _selectedIndex == 0
                    ? WidgetStatePropertyAll(ElColor.darkBlue500)
                    : WidgetStatePropertyAll(ElColor.transparent),
              ),
              icon: Icon(
                size: Sizes.xl,
                Icons.home,
                semanticLabel: Config.bottomNavHomeText,
                color:
                    _selectedIndex == 0 ? ElColor.textWhite : ElColor.darkBlue,
              ),
              onPressed: () {
                onIconPressed(0);
              },
            ),
            IconButton(
              tooltip: Config.bottomNavGalleryText,
              style: ButtonStyle(
                backgroundColor: _selectedIndex == 1
                    ? WidgetStatePropertyAll(ElColor.darkBlue500)
                    : WidgetStatePropertyAll(ElColor.transparent),
              ),
              icon: Icon(
                semanticLabel: Config.bottomNavGalleryText,
                size: Sizes.xl,
                Icons.image_rounded,
                color:
                    _selectedIndex == 1 ? ElColor.textWhite : ElColor.darkBlue,
              ),
              onPressed: () {
                onIconPressed(1);
              },
            ),
            SizedBox(
              width: Sizes.f1,
            ),
            IconButton(
              tooltip: Config.bottomNavMVText,
              style: ButtonStyle(
                backgroundColor: _selectedIndex == 2
                    ? WidgetStatePropertyAll(ElColor.darkBlue500)
                    : WidgetStatePropertyAll(ElColor.transparent),
              ),
              icon: Icon(
                semanticLabel: Config.bottomNavMVText,
                size: Sizes.xl,
                Icons.business_rounded,
                color:
                    _selectedIndex == 2 ? ElColor.textWhite : ElColor.darkBlue,
              ),
              onPressed: () {
                onIconPressed(2);
              },
            ),
            IconButton(
              tooltip: Config.bottomNavByText,
              style: ButtonStyle(
                backgroundColor: _selectedIndex == 3
                    ? WidgetStatePropertyAll(ElColor.darkBlue500)
                    : WidgetStatePropertyAll(ElColor.transparent),
              ),
              icon: Icon(
                semanticLabel: Config.bottomNavByText,
                size: Sizes.xl,
                Icons.auto_stories_rounded,
                color:
                    _selectedIndex == 3 ? ElColor.textWhite : ElColor.darkBlue,
              ),
              onPressed: () {
                onIconPressed(3);
              },
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
            Mv(),
            ByLaws(),
          ],
        ),
      ),
    );
  }
}

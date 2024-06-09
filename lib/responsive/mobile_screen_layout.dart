import 'package:flutter/material.dart';
import 'package:insta_clone/utils/GlobalVariables.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return
        // Define your pages here
        homeScreenItems;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          size: 35,
        ),
        inactiveIcon: const Icon(
          Icons.home_outlined,
          size: 35,
        ),
        // title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.people,
          size: 35,
        ),
        inactiveIcon: const Icon(
          Icons.people_outline,
          size: 35,
        ),
        // title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black87, width: 1)),
          child: const Icon(
            Icons.videocam,
            color: Colors.black,
          ),
        ),
        iconSize: 35,
        inactiveIcon: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black87, width: 1)),
          child: const Icon(
            Icons.videocam,
            color: Colors.black,
          ),
        ),
        // title: ("Home"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.notifications,
          size: 35,
        ),
        inactiveIcon: const Icon(
          Icons.notifications_none_outlined,
          size: 35,
        ),
        // title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          size: 35,
        ),
        inactiveIcon: const Icon(
          Icons.person_outline,
          size: 35,
        ),
        // title: ("Home"),

        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black54,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,

        navBarHeight: 70,
        screens: _buildScreens(),
        items: _navBarsItems(),

        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when the keyboard appears.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'true' to hide the nav bar when keyboard appears.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(
            width: 0,
          ),
          // colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle
            .style15, // Choose the nav bar style with raised middle icon.
      ),
    );
  }
}

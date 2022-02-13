import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'home_page.dart';
// import 'home_page.dart';

class NavBarUser extends StatefulWidget {
  const NavBarUser({Key key}) : super(key: key);

  @override
  _NavBarUserState createState() => _NavBarUserState();
}

class _NavBarUserState extends State<NavBarUser> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // HomePageUser(),
    HomePageUser(),
    Text('Data Presensi'),
    Text('Profile'),
  ];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
      onWillPop: () async {
        Future.value(
            false); //return a `Future` with false value so this route cant be popped or closed.
      },
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: buildCustomNavigationBar(),
      ),
    );
  }

  CustomNavigationBar buildCustomNavigationBar() {
    return CustomNavigationBar(
        scaleFactor: 0.4,
        backgroundColor: Colors.white,
        selectedColor: Colors.black,
        unSelectedColor: new Color(0xFF7F8C8D),
        strokeColor: new Color(0xFFF39C12),
        currentIndex: _currentIndex,
        onTap: onTappedBar,
        items: [
          CustomNavigationBarItem(icon: Icons.home),
          CustomNavigationBarItem(icon: Icons.card_giftcard),
          CustomNavigationBarItem(icon: Icons.person),
        ]);
  }
}

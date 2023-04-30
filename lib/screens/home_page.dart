import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/previous_orders.dart';
import 'package:flutter/material.dart';

import '../constract/color_string.dart';
import 'choose_location_screen.dart';
import 'edit_profile_screen.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({required this.userType});

  var userType;

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int currentTab = 0;
  late List<Widget> screens;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = EditProfileScreen(userType: '');

  @override
  void initState() {
    super.initState();
    screens = [
      EditProfileScreen(userType: widget.userType),
      GoogleMapScreen(),
      PreviousOrdersScreen(),
    ];
    currentScreen = screens[currentTab];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3,
        color: Colors.white,
        child: Container(
          color: AOUAppBar,
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[0];
                      currentTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: currentTab == 0 ? Colors.black : Colors.black38,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[1];
                      currentTab = 1;
                    });
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: currentTab == 1 ? Colors.black : Colors.black38,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = screens[2];
                      currentTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: currentTab == 2 ? Colors.black : Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

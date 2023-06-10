import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_project/acces.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
import 'package:pfe_project/constants.dart';
import 'package:pfe_project/edit_profile.dart';

import 'package:pfe_project/fire.dart';
import 'package:pfe_project/login.dart';
import 'package:pfe_project/motion.dart';
import 'package:pfe_project/notification_alert.dart';
import 'package:pfe_project/settings.dart';
import 'package:pfe_project/temperature.dart';

import '../../hum.dart';
import '../../map.dart';
import '../../user_account.dart';

class Dashboardbody extends StatefulWidget {
  const Dashboardbody({super.key});

  get size => null;

  @override
  State<Dashboardbody> createState() => _DashboardbodyState();
}

class _DashboardbodyState extends State<Dashboardbody> {
  int _selectedIndex = 0;
  List<BottomNavItem> navItems = [
    BottomNavItem(
      icon: Icons.person,
      label: 'Account',
      route: '/user',
    ),
    BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      route: '/dashboard',
    ),
    BottomNavItem(
      icon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
    BottomNavItem(
      icon: Icons.notifications,
      label: 'Notification',
      route: '/notification',
    ),
  ];

  void _onItemTapped(int index, BuildContext context) {
    // Add BuildContext parameter
    switch (navItems[index].route) {
      case '/dashboard':
        Navigator.pushNamed(context, 'dashboard');
        break;
      case '/user':
        Navigator.pushNamed(context, 'user');
        break;
      case '/settings':
        Navigator.pushNamed(context, 'settings');
        break;
      case '/notification':
        Navigator.pushNamed(context, 'notification');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: size.height * 0.1),
              Center(
                child: Text(
                  "SECURITY IS MORE IMPORTANT THAN EVER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F51B5),
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Center(
                child: Text(
                  "Press all that applies . This will help you control the condition of your room .",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkGreyColor,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccesPage(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/3234055.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Access\n',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MotionDetector(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/motion1.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Motion\n Detector',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FireDetector(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/fire-station.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Fire\nDetector',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyMap(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/mapp.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Map\n',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HumPage(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/humd.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Humidity\n',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TemperaturePage(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/tempp.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Temperature\n',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(
                            notifications: ['error1'],
                          ),
                        ),
                      );
                    },

                    icon:
                        'assets/image/notif.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Notification\n',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/account_.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Account\n',
                  ),
                  ControlButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ),
                      );
                    },

                    icon:
                        'assets/image/setting.png', /////////////////////////////erreur ici !!!!!!!!!!!!
                    title: 'Setting\n',
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        iconSize: 30,
        selectedItemColor: Colors.black38,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          _onItemTapped(index, context);
        },
        items: navItems
            .map(
              (navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.icon),
                label: navItem.label,
              ),
            )
            .toList(),
      ),*/
    );
  }

  Widget ControlButton({
    bool isSelected = false,
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = const Color.fromARGB(255, 79, 96, 193),
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: 110,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color,
        ),
        child: Column(
          children: [
            Image.asset(
              color: Colors.white,
              icon,
              height: 80,
              width: 90,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

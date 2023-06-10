import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfe_project/bottom_nav_bar.dart';

class NotifDetail extends StatefulWidget {
  final Map<String, dynamic>
      notifications; // Change the type to Map<String, dynamic>

  const NotifDetail({Key? key, required this.notifications}) : super(key: key);
  @override
  State<NotifDetail> createState() => _NotifDetailState();
}

class _NotifDetailState extends State<NotifDetail> {
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
    final notification = widget.notifications;
    IconData iconData;
    switch (notification['type']) {
      case 'humidity':
        iconData = Icons.waves;
        break;
      case 'Temperature':
        iconData = Icons.thermostat;
        break;
      case 'rfid':
        iconData = Icons.credit_card;
        break;
      case 'motion':
        iconData = Icons.warning;
        break;
      default:
        iconData = Icons.notifications;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 1,
        title: Text('Notifications Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  notification['type'],
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              notification['message'],
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              notification['time'],
              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            /* ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('Take Action'),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}

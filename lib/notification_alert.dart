import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
import 'package:pfe_project/notification_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe_project/socket_service.dart';

class NotificationPage extends StatefulWidget {
  final List<dynamic> notifications; // List of notifications

  NotificationPage({required this.notifications});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedIndex = 0;
  List<dynamic> notifications = [];
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

  void _handleNotification(dynamic data) {
    setState(() {
      notifications.add(data.toString());
    });
  }

  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('http://10.10.23.177:8000/api/Notification'), headers: {
      'Authorization': '$token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List<dynamic> notificationList = List<dynamic>.from(responseBody);
      /*  List<String> notificationMessages = [];
  
    for (var notification in notificationList) {
      String message = notification['message'];
      notificationMessages.add(message);
    }
    */

      setState(() {
        notifications = notificationList;
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 1,
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              notifications[index]['message'],
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotifDetail(notifications: notifications[index]),
                ),
              );
              // Navigate to notification detail page
            },
          );
        },
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

class NotificationBlock extends StatelessWidget {
  final String notification;
  final VoidCallback onTap;

  const NotificationBlock({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        notification,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

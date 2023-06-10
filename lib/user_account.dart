import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pfe_project/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_bar.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
import 'Dashboard/components/body.dart';
import 'package:pfe_project/calendar.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? userData;
  String? token;
  String? name;
  String? email;
  String? phone;
  String? address;

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
  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

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
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(
          'token'); // Retrieve the token from SharedPreferences or another storage mechanism

      final response = await http.get(
        Uri.parse('http://10.10.23.177:8000/api/user'),

        headers: {
          'Authorization': '$token'
        }, // Include the token in the Authorization header
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('data: $data');
        name = data['name'];
        email = data['email'];
        phone = data['phone'];
        address = data['address'];

        print('name: $name');
        print('email: $email');
        print('phone: $phone');
        print('address: $address');
        setState(() {
          userData = {
            'name': name,
            'email': email,
            'phone': phone,
            'address': address,
          };
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 1,
        title: Text('User Profile'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/image/mkk.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 28),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  phone ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Address',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  address ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'email',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  email ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                      child: Text(
                        'Edit Account',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Adjust the desired space between the buttons
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                      onPressed: _signOut,
                      child: Text(
                        'SIGN OUT',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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

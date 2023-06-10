import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pfe_project/Dashboard/components/body.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
import 'package:pfe_project/edit_profile.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfe_project/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*import 'package:settings_screen/settings_screen.dart';*/

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

/*Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}*/
class _SettingPageState extends State<SettingPage> {
  bool _notificationEnabled = true;
  Set<String> _notificationTypes = {'Event reminders', 'News updates'};
  Locale _locale = const Locale('en'); // default language is English
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  void _toggleNotification(bool value) {
    setState(() {
      _notificationEnabled = value;
    });
  }

  // This method is called when the user checks/unchecks a notification type
  void _toggleNotificationType(String type, bool value) {
    setState(() {
      if (value) {
        _notificationTypes.add(type);
      } else {
        _notificationTypes.remove(type);
      }
    });
  }

  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

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
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      // Add any other light theme properties here
    );
    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      // Add any other dark theme properties here
    );

    return Localizations(
      locale: _locale,
      delegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: MaterialApp(
        routes: {
          '/login': (context) => MyLogin(),
        },
        theme: _darkModeEnabled ? darkTheme : lightTheme,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.indigo,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                //line under the text
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Edit Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    DropdownButton<String>(
                      value: _selectedLanguage,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue!;
                        });
                      },
                      items: <String>['English', 'French', 'Arabic']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enable Notifications",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Switch(
                      value: _notificationEnabled,
                      onChanged: _toggleNotification,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Notification Types",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                CheckboxListTile(
                  title: Text("Event reminders"),
                  value: _notificationTypes.contains("Event reminders"),
                  onChanged: (value) =>
                      _toggleNotificationType("Event reminders", value!),
                ),
                CheckboxListTile(
                  title: Text("News updates"),
                  value: _notificationTypes.contains("News updates"),
                  onChanged: (value) =>
                      _toggleNotificationType("News updates", value!),
                ),
                // Add more CheckboxListTile widgets for other notification types
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                          ThemeMode themeMode = _darkModeEnabled
                              ? ThemeMode.dark
                              : ThemeMode.light;
                          (context as Element).markNeedsBuild();
                        });
                      },
                    ),
                  ],
                ),
                /*    SizedBox(
                  height: 30,
                ),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
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
        ),
      ),
    );

    void _changeLanguage(String languageCode) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
  }
}

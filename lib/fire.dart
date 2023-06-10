import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:ui' as ui;
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:pfe_project/bottom_nav_bar.dart';
import 'package:pfe_project/calendar.dart';

class FireDetector extends StatefulWidget {
  const FireDetector({Key? key}) : super(key: key);

  @override
  State<FireDetector> createState() => _FireDetectorState();
}

class _FireDetectorState extends State<FireDetector>
    with SingleTickerProviderStateMixin {
  bool isChecked = false;
  bool _showHistory = false;
  String flame = '';
  DateTime? lastDateTime;
  String? flameDataTime;
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

  Future<void> fetchflameData() async {
    final url =
        'http://10.10.23.177:8000/api/flame'; // Replace with your actual API endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final flameValue = data['value'];
      final DataTime = data[
          'timestamp']; // Replace 'value' with the actual key in your JSON response
      print('flame Data -->: $flameValue');
      print('time Data -->: $flameDataTime');
      setState(() {
        flame = flameValue;
        flameDataTime = DataTime;
      });
      if (flame == 'Flame Detected') {
        isChecked = true;
      }
    } else {
      // Handle the error case
    }
  }

  Widget _showLastDateTime() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        'Last updated:\n ${flameDataTime != null ? DateFormat.yMMMMd().add_jms().format(DateTime.parse(flameDataTime!)) : 'N/A'}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchflameData();
  }

  void _toggleHistory(bool value) {
    setState(() {
      _showHistory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /* appBar: AppBar(
title: Text("Fire Detector"),
),*/
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              /*
              SizedBox(height: size.height * 0.03),
              Text(
                "FIRE DETECTOR PAGE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ui.Color.fromARGB(255, 8, 30, 48),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Fire Detecor with Flame Sensor ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ui.Color.fromARGB(255, 8, 30, 48),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),*/

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 5),
                    CircularPercentIndicator(
                      radius: 90,
                      lineWidth: 9,
                      percent: 1.0,
                      progressColor: isChecked ? Colors.red : Colors.green,
                      center: isChecked
                          ? Image.asset(
                              'assets/image/house1.png',
                              height: 135,
                              width: 100,
                            )
                          : Image.asset(
                              'assets/image/house3.png',
                              height: 135,
                              width: 100,
                            ),
                    ),

                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        isChecked ? 'FIRE \n DETECTED' : 'FIRE \n NOT-DETECTED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isChecked ? Colors.red.shade800 : Colors.green,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Add spacing between image and text
                    Text(
                      isChecked
                          ? 'Authorized access.\n Welcome to your safe workplace!'
                          : 'Security breach detected.\n Please verify your identity !',
                      textAlign: TextAlign.center, // Add your text here
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: _roundedButton(
                            title: 'GENERAL',
                            isActive: !_showHistory,
                            onTap: () => _toggleHistory(false),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: _roundedButton(
                            title: 'HISTORIQUE',
                            isActive: _showHistory,
                            onTap: () => _toggleHistory(true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Visibility(
                      visible: _showHistory,
                      child: SizedBox(
                        width: 300, // Set a specific width for the chart
                        height: 400, // Set a specific height for the chart
                        child: HeatMapCalendarWidget(),
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(child: _showLastDateTime()),
                    /*  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/image/Tunisie-Telecom.jpg', // Replace with your image file path
                        height: 130,
                        width: 120,
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
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

  Widget _roundedButton(
      {required String title,
      required bool isActive,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap(); // Call onTap as a function
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        decoration: BoxDecoration(
          color: isActive ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.indigo,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

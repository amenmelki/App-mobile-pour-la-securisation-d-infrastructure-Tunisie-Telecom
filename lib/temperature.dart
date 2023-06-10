import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pfe_project/bottom_nav_bar.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pfe_project/temp_hist.dart';
import 'package:http/http.dart' as http;

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  double temperature = 0.0;
  DateTime? lastDateTime;
  String? tempDataTime;
  double max_temp = 50;
  bool _showHistory = false; // new variable
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

  Future<void> fetchTemperatureData() async {
    final url =
        'http://10.10.23.177:8000/api/temperature'; // Replace with your actual API endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperatureValue = data['temperature'];
      final DataTime = data[
          'timestamp']; // Replace 'value' with the actual key in your JSON response
      print('temperature Data -->: $temperatureValue');
      print('time Data -->: $tempDataTime');
      setState(() {
        temperature = temperatureValue;
        tempDataTime = DataTime;
      });
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
        'Last updated: ${tempDataTime != null ? DateFormat.yMMMMd().add_jms().format(DateTime.parse(tempDataTime!)) : 'N/A'}',
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
    fetchTemperatureData();
  }

  void _toggleHistory(bool value) {
    setState(() {
      _showHistory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
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
                  const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 5),
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15,
                      percent: temperature / 100,
                      progressColor:
                          temperature > max_temp ? Colors.red : Colors.green,
                      center: Text(
                        '${temperature.toStringAsFixed(1)}°',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'TEMPERATURE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
                    Visibility(
                      visible: _showHistory,
                      child: SizedBox(
                        width: 300, // Set a specific width for the chart
                        height: 300, // Set a specific height for the chart
                        child: TemperatureHistoryChart(
                          data: [
                            TemperatureData(
                                time: DateTime(2023, 5, 1), temperature: 25),
                            TemperatureData(
                                time: DateTime(2023, 5, 2), temperature: 24),
                            TemperatureData(
                                time: DateTime(2023, 5, 3), temperature: 22),
                            TemperatureData(
                                time: DateTime(2023, 5, 4), temperature: 21),
                            TemperatureData(
                                time: DateTime(2023, 5, 5), temperature: 20),
                            TemperatureData(
                                time: DateTime(2023, 5, 6), temperature: 18),
                            TemperatureData(
                                time: DateTime(2023, 5, 7), temperature: 16),
                            TemperatureData(
                                time: DateTime(2023, 5, 8), temperature: 15),
                            TemperatureData(
                                time: DateTime(2023, 5, 9), temperature: 30),
                            TemperatureData(
                                time: DateTime(2023, 5, 10), temperature: 45),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(child: _showLastDateTime()),
                    /*Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      
                    ),*/
                    //cruve data ********
                    /* SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: TemperatureHistoryChart(
                        data: [
                          TemperatureData(
                              time: DateTime(2023, 5, 1), temperature: 25),
                          TemperatureData(
                              time: DateTime(2023, 5, 2), temperature: 24),
                          TemperatureData(
                              time: DateTime(2023, 5, 3), temperature: 22),
                          TemperatureData(
                              time: DateTime(2023, 5, 4), temperature: 21),
                          TemperatureData(
                              time: DateTime(2023, 5, 5), temperature: 20),
                          TemperatureData(
                              time: DateTime(2023, 5, 6), temperature: 18),
                          TemperatureData(
                              time: DateTime(2023, 5, 7), temperature: 16),
                          TemperatureData(
                              time: DateTime(2023, 5, 8), temperature: 15),
                          TemperatureData(
                              time: DateTime(2023, 5, 9), temperature: 30),
                          TemperatureData(
                              time: DateTime(2023, 5, 10), temperature: 45),
                        ],
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

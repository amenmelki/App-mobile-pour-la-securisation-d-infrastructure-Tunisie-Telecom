import 'package:flutter/material.dart';
import 'package:pfe_project/dataplace.dart';
import 'package:pfe_project/login.dart';
import 'package:pfe_project/notification_alert.dart';
import 'package:pfe_project/regsiter.dart';
import 'package:pfe_project/home.dart';
import 'package:pfe_project/settings.dart';
import 'package:pfe_project/user_account.dart';
import 'Dashboard/dashboard_iot.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe_project/dataplace.dart';
import 'socket_service.dart';

Future<String> getSavedString() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  return token;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the binding
  final token = await getSavedString();
  print(token);
  if (token.isNotEmpty) {
    // SocketService().initSocket();
  }
  runApp(
    SocketServiceWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: token.isEmpty ? 'login' : 'dashboard',
        routes: {
          'home': (context) => const MyHome(),
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'dashboard': (context) => const Dashboard(),
          'settings': (context) => const SettingPage(),
          'dataplace': (context) => DataPlacesPage(),
          'notification': (context) => NotificationPage(
                notifications: const ['null'],
              ),
          'user': (context) => UserProfileScreen(),
        },
      ),
    ),
  );
  print(token);
}

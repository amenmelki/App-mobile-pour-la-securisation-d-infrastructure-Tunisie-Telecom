import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/mailer.dart' show Message, Address, send, SmtpServer;
import 'package:mailer/smtp_server.dart';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
/*  static Future<void> sendSMSNotification(
      String phoneNumber, String message) async {
    List<String> recipients = [
      phoneNumber
    ]; // Replace with the recipient's phone number(s)
    String body = message; // Replace with the SMS message content

    try {
      String _result = await sendSMS(
        message: body,
        recipients: recipients,
      );
      print('SMS notification sent successfully. Result: $_result');
    } catch (error) {
      print('Failed to send SMS notification: $error');
    }
  }
*/
  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Replace with your app icon resource name
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(data) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name', // Replace with your channel name
      channelDescription:
          'hii ye king', // Replace with your channel description
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    print("nottext fost l pop $data");

    String type = data['type'];
    String msg = data['msg'];

    await flutterLocalNotificationsPlugin.show(
      0,
      type,
      msg,
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }
}

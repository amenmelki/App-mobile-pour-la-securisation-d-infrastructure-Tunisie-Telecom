import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'notif_pop.dart';

class SocketServiceWidget extends StatelessWidget {
  final Widget child;

  const SocketServiceWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return _SocketService(child: child);
  }
}

class _SocketService extends StatefulWidget {
  final Widget child;

  const _SocketService({required this.child});

  @override
  __SocketServiceState createState() => __SocketServiceState();
}

class __SocketServiceState extends State<_SocketService> {
  IO.Socket? socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initSocket();
    NotificationHelper
        .initializeNotifications(); // Call the initialization method here
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  void initSocket() {
    socket = IO.io('http://10.10.23.177:8000/', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket?.onConnect((_) {
      print('Connected to server');
      setState(() {
        isConnected = true;
      });

      socket?.on('get_id', (data) async {
        print('Received notification: $data');
        final String url = 'http://10.10.23.177:8000/api/postNotId';
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString(
            'token'); // Retrieve the token from SharedPreferences or another storage mechanism

        final body = {'data': data[0]};
        print('bd $body');
        try {
          final http.Response response = await http.post(
            Uri.parse(url),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json'
            },
            body: jsonEncode(body),
          );
          // Process the received notification data in your Flutter app
        } catch (error) {
          print('Error posting notification: $error');
        }
      });

      socket?.on('serverTophone', (data) {
        print('Received server data: $data');
        NotificationHelper.showNotification(data['data']);
        /*    NotificationHelper.sendSMSNotification('+21652473285', data.toString());*/
      });

      socket?.onDisconnect((_) {
        print('Disconnected from Socket.IO server');
        setState(() {
          isConnected = false;
        });
        reconnect(); // Attempt to reconnect
      });
    });

    try {
      socket!.connect();
    } on Exception catch (error) {
      print(error);
    }
  }

  void reconnect() {
    if (!isConnected) {
      print('Reconnecting to server...');
      try {
        socket?.connect(); // Reconnect to the server
      } catch (error) {
        print('Error reconnecting to Socket.IO server: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

import 'package:flutter/material.dart';
import 'package:pfe_project/notification_detail.dart';

class NotificationItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const NotificationItem({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotifDetail(
              notifications: {},
            ),
          ),
        );
        // Navigate to notification detail page
      },
    );
  }
}

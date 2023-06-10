import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

List<DateTime> flameDetectionDates = [
  DateTime(2023, 5, 1), // Example date
  DateTime(2023, 5, 5),
  DateTime(2023, 5, 13),
  DateTime(2023, 5, 18),
  DateTime(2023, 5, 20),
  // Example date
  // Add more dates as per your data
];

class HeatMapCalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Set your desired maximum height
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              child: HeatMapCalendar(
                textColor: Colors.black,
                defaultColor: Colors.white,
                flexible: true,
                colorMode: ColorMode.color,
                datasets: _buildDatasets(),
                colorsets: _buildColorsets(),
                onClick: (value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<DateTime, int> _buildDatasets() {
    Map<DateTime, int> datasets = {};

    for (DateTime date in flameDetectionDates) {
      datasets[date] = 1; // Assign a value of 1 to indicate flame detection
    }

    return datasets;
  }

  Map<int, Color> _buildColorsets() {
    borderRadius:
    BorderRadius.circular(7.0);
    return const {
      0: Colors.white, // Default color for non-flame detection days
      1: Colors.black26, // Color for flame detection days
    };
  }
}

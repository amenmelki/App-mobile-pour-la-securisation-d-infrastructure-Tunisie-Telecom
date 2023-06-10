import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureHistoryChart extends StatelessWidget {
  final List<TemperatureData> data;

  const TemperatureHistoryChart({
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <ChartSeries>[
        LineSeries<TemperatureData, DateTime>(
          dataSource: data,
          xValueMapper: (TemperatureData temp, _) => temp.time,
          yValueMapper: (TemperatureData temp, _) => temp.temperature,
        ),
      ],
    );
  }
}

/*
    return charts.TimeSeriesChart(
      _createTemperatureSeries(),
      animate: true,
      defaultRenderer: charts.LineRendererConfig(),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(
            format: 'd',
            transitionFormat: 'MMM d',
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          <charts.TickSpec<num>>[
            charts.TickSpec<num>(0),
            charts.TickSpec<num>(15),
            charts.TickSpec<num>(30),
            charts.TickSpec<num>(45),
            charts.TickSpec<num>(60),
          ],
        ),
      ),
    );*/

/*
  List<charts.Series<TemperatureData, DateTime>> _createTemperatureSeries() {
    return [
      charts.Series<TemperatureData, DateTime>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (TemperatureData temp, _) => temp.time,
        measureFn: (TemperatureData temp, _) =>
            temp.temperature != null ? temp.temperature.toInt() : 0,
        data: widget.data,
      )
    ];
  }*/

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData({required this.time, required this.temperature});
}

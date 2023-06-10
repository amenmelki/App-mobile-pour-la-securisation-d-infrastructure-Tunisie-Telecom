import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class HumidityHistoryChart extends StatelessWidget {
  final List<HumidityData> data;

  const HumidityHistoryChart({
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <ChartSeries>[
        LineSeries<HumidityData, DateTime>(
          dataSource: data,
          xValueMapper: (HumidityData temp, _) => temp.time,
          yValueMapper: (HumidityData temp, _) => temp.humidity,
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

class HumidityData {
  final DateTime time;
  final double humidity;

  HumidityData({required this.time, required this.humidity});
}

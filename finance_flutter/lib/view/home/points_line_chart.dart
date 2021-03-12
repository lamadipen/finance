/// Line chart example
import 'dart:html';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsLineChart extends StatelessWidget {
  final bool animate = true;

  //PointsLineChart(this.seriesList, {this.animate});

  // /// Creates a [LineChart] with sample data and no transition.
  // factory PointsLineChart.withSampleData() {
  //   return new PointsLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      if (state is TransactionLoadInProgressState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is TransactionLoadFailureState) {
        return Center(
          child: Text('failed to fetch posts'),
        );
      }
      final List<Transaction> _transactions =
          state is TransactionsLoadSuccessState ? state.transactions : [];
      List<charts.Series<TimeSeriesSales, DateTime>> seriesList =
      _createData(_transactions);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Sales and total profit over time.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 300.0,
              child: charts.TimeSeriesChart(
                seriesList,
                animate: animate,
                defaultRenderer: new charts.LineRendererConfig(),
                customSeriesRenderers: [
                  charts.PointRendererConfig(customRendererId: 'customPoint')
                ],
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ))
        ],
      );
    });
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createData(
      transactions) {
    List<TimeSeriesSales> desktopSalesData = List<TimeSeriesSales>.from(transactions.map((Transaction t) => TimeSeriesSales(t.date, t.amount.toInt())));

    // final desktopSalesData = [
    //   new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
    //   new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
    //   new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
    //   new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    // ];

    final tableSalesData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 200),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 150),
    ];

    final mobileSalesData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 200),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 150),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: desktopSalesData,
        displayName: 'Sales'
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: tableSalesData,
        displayName: 'loss'
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: mobileSalesData)
      // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];

  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>>
      _createSampleDateTimeData() {
    final desktopSalesData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    final tableSalesData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 200),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 150),
    ];

    final mobileSalesData = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 200),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 150),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

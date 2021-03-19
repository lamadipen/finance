import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleSeriesLegend extends StatelessWidget {
  // final List<charts.Series> seriesList;
  final bool animate = true;

  //
  // SimpleSeriesLegend(this.seriesList, {this.animate});

  // factory SimpleSeriesLegend.withSampleData() {
  //   return new SimpleSeriesLegend(
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
      List<charts.Series<OrdinalSales, String>> seriesList =
          _createSampleData(_transactions);

      return Column(
        children: [
          Text(
            'Monthly Report.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 300.0,
              child: charts.BarChart(
                seriesList,
                animate: animate,
                barGroupingType: charts.BarGroupingType.grouped,
                // Add the series legend behavior to the chart to turn on series legends.
                // By default the legend will display above the chart.
                behaviors: [charts.SeriesLegend()],
              ))
        ],
      );
    });
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      transactions) {
    List<OrdinalSales> revenue = List<OrdinalSales>.from(transactions
        .where((Transaction t) =>
            t.category == Category.REVENUE.name)
        .map((Transaction t) =>
            OrdinalSales(t.date.year.toString(), t.amount.toInt())));

    List<OrdinalSales> expenses = List<OrdinalSales>.from(transactions
        .where((Transaction t) =>
            t.category == Category.EXPENSES.name)
        .map((Transaction t) =>
            OrdinalSales(t.date.year.toString(), t.amount.toInt())));

    final costOfGoodsSold = List<OrdinalSales>.from(transactions
        .where((Transaction t) =>
            t.category == Category.COST_OF_GOODS_SOLD.name)
        .map((Transaction t) =>
            OrdinalSales(t.date.year.toString(), t.amount.toInt())));
    // final desktopSalesData = [
    //   new OrdinalSales('2014', 5),
    //   new OrdinalSales('2015', 25),
    //   new OrdinalSales('2016', 100),
    //   new OrdinalSales('2017', 75),
    // ];

    // final tabletSalesData = [
    //   new OrdinalSales('2014', 25),
    //   new OrdinalSales('2015', 50),
    //   new OrdinalSales('2016', 10),
    //   new OrdinalSales('2017', 20),
    // ];

    // final mobileSalesData = [
    //   new OrdinalSales('2014', 10),
    //   new OrdinalSales('2015', 15),
    //   new OrdinalSales('2016', 50),
    //   new OrdinalSales('2017', 45),
    // ];

    // final otherSalesData = [
    //   new OrdinalSales('2014', 20),
    //   new OrdinalSales('2015', 35),
    //   new OrdinalSales('2016', 15),
    //   new OrdinalSales('2017', 10),
    // ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Revenue',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: revenue,
          seriesColor: charts.Color.fromHex(code: '#08B90B')),
      new charts.Series<OrdinalSales, String>(
          id: 'Expenses',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: expenses,
          seriesColor: charts.Color.fromHex(code: '#E55520')),
      new charts.Series<OrdinalSales, String>(
        id: 'Cost Of Goods Sold',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: costOfGoodsSold,
      )
    ];
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleDataBackup() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Other',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

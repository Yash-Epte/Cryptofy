import 'dart:convert';

import 'package:crytojay/config/constants/constant.dart';
import 'package:crytojay/config/extension/context.dart';
import 'package:crytojay/models/prediction_model.dart';
import 'package:crytojay/pages/loading/loading.dart';
import 'package:crytojay/providers/coins_provider.dart';
import 'package:crytojay/widgets/home/background_curves_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends ConsumerStatefulWidget {
  const Charts(
      {super.key,
      required this.predictedData,
      required this.monthlyData,
      required this.dailyData,
      required this.coinId});
  final Map<String, dynamic> predictedData;
  final Map<String, dynamic> monthlyData;
  final Map<String, dynamic> dailyData;
  final String coinId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartsState();
}

class _ChartsState extends ConsumerState<Charts> {
  bool showDaily = false;
  @override
  Widget build(BuildContext context) {
    List<PredictionModel> dailyGraph = (widget.dailyData['predictions']
            as List<dynamic>)
        .map((prediction) => PredictionModel.fromJson(jsonEncode(prediction)))
        .toList();

    List<PredictionModel> monthlyGraph = (widget.monthlyData['predictions']
            as List<dynamic>)
        .map((prediction) => PredictionModel.fromJson(jsonEncode(prediction)))
        .toList();

    List<PredictionModel> predictions = (widget.predictedData['predictions']
            as List<dynamic>)
        .map((prediction) => PredictionModel.fromJson(jsonEncode(prediction)))
        .toList();
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -300,
              top: -00,
              child: Container(
                height: 500,
                width: 600,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            CustomPaint(
              painter: BackgroundCurvesPainter(),
              size: Size.infinite,
            ),
            Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.25),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'CryptoFy',
                            style: TextStyle(
                              color: context.colorScheme.background,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Icon(
                            IconlyLight.chart,
                            color: Colors.black,
                            // scale: 23,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.coinId.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.monetization_on_outlined)
                        ],
                      ),
                      FlutterSwitch(
                        // width: 55.0,
                        // height: 55.0,
                        // valueFontSize: 25.0,
                        toggleSize: 25.0,
                        borderRadius: 30.0,
                        activeIcon: Icon(
                          IconlyLight.calendar,
                        ),
                        inactiveIcon: Icon(
                          IconlyBold.calendar,
                        ),
                        padding: 8.0,
                        activeColor: Color(0xffadfa00).withOpacity(0.6),
                        onToggle: (toggle) {
                          setState(() {
                            showDaily = toggle;
                          });
                        },
                        value: showDaily,
                      ),
                    ],
                  ),
                ),
                if(showDaily)
                SizedBox(
                  width: 380,
                  height: 240,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Past 24 hours"),
                    // Initialize category axis
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: "Prices (₹)"),
                      numberFormat: NumberFormat.compactCurrency(
                        locale: 'en_In',
                        symbol: "₹",
                        decimalDigits: 3,
                      ),
                    ),
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.hours,
                      interval: 2,
                      dateFormat: DateFormat.H(),
                      title: AxisTitle(text: "hours"),
                    ),
                    series: <LineSeries<PredictionModel, DateTime>>[
                      LineSeries<PredictionModel, DateTime>(
                        dataSource: dailyGraph,
                        xValueMapper: (PredictionModel dailyGraph, _) =>
                            dailyGraph.timeStamp,
                        yValueMapper: (PredictionModel dailyGraph, _) =>
                            dailyGraph.price,
                      ),
                    ],
                    enableAxisAnimation: true,
                  ),
                ),
                if(!showDaily)
                SizedBox(
                  width: 380,
                  height: 240,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Past Month"),
                    // Initialize category axis
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: "Prices (₹)"),
                      numberFormat: NumberFormat.compactCurrency(
                        locale: 'en_In',
                        symbol: "₹",
                        decimalDigits: 3,
                      ),
                    ),
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.days,
                      interval: 2,
                      dateFormat: DateFormat.d(),
                      title: AxisTitle(text: "days"),
                    ),
                    series: <LineSeries<PredictionModel, DateTime>>[
                      LineSeries<PredictionModel, DateTime>(
                        dataSource: monthlyGraph,
                        xValueMapper: (PredictionModel monthlyGraph, _) =>
                            monthlyGraph.timeStamp,
                        yValueMapper: (PredictionModel monthlyGraph, _) =>
                            monthlyGraph.price,
                      ),
                    ],
                    enableAxisAnimation: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Prediction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.rocket_launch_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            (widget.predictedData["Accuracy "]).toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      // Text("Switch"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 400,
                    height: 240,
                    child: SfCartesianChart(
                      title: ChartTitle(text: "Predicted 24 hours"),
                      // Initialize category axis
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(text: "Prices (₹)"),
                        numberFormat: NumberFormat.compactCurrency(
                          locale: 'en_In',
                          symbol: "₹",
                          decimalDigits: 3,
                        ),
                      ),
                      primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.hours,
                        interval: 2,
                        dateFormat: DateFormat.H(),
                        title: AxisTitle(text: "hours"),
                      ),
                      series: <LineSeries<PredictionModel, DateTime>>[
                        LineSeries<PredictionModel, DateTime>(
                          dataSource: predictions,
                          xValueMapper: (PredictionModel prediction, _) =>
                              prediction.timeStamp,
                          yValueMapper: (PredictionModel prediction, _) =>
                              prediction.price,
                        ),
                      ],
                      enableAxisAnimation: true,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var unixTimeMilliseconds =
              DateTime.now().millisecondsSinceEpoch ~/ 1000;

          var aMonthAgo = DateTime.now().subtract(const Duration(days: 60));

          var unixTimeAMonthAgo = aMonthAgo.millisecondsSinceEpoch ~/ 1000;

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Loading();
          }));
          try {
            final predictedData = await ref.read(
              getPredictDataProvider(
                      coinName: widget.coinId,
                      endTime: unixTimeMilliseconds,
                      fromTime: unixTimeAMonthAgo)
                  .future,
            );
            final montlyData = await ref.read(getMontlyDataProvider(
              coinName: widget.coinId,
            ).future);

            final dailyData = await ref.read(getDailyDataProvider(
              coinName: widget.coinId,
            ).future);

            // print("This is the predicted Data $predictedData");
            // print("This is the montly Data $montlyData");
            // print("This is the daily Data $dailyData");
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Charts(
                predictedData: predictedData,
                monthlyData: montlyData,
                dailyData: dailyData,
                coinId: widget.coinId,
              );
            }));
          } catch (e) {
            print("An error occured print $e");
          }
        },
        child: Icon(
          Icons.rocket,
          color: Colors.black87,
        ),
        backgroundColor: Color(0xffadfa00),
      ),
    );
  }
}

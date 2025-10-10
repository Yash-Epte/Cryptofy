import 'package:crytojay/pages/charts/charts.dart';
import 'package:crytojay/pages/loading/loading.dart';
import 'package:crytojay/providers/coins_provider.dart';
import 'package:crytojay/widgets/home/background_curves_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({
    super.key,
    required this.coin_id,
  });
  final String coin_id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -600,
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
                  height: 40,
                ),
                Text(
                  "Select the range",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TableCalendar(
                  firstDay: DateTime.utc(2014, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarStyle: CalendarStyle(
                      rangeHighlightColor: Color(0xffadfa00).withOpacity(0.4)),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _rangeStart = null; // Important to clean those
                        _rangeEnd = null;
                        _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      });
                    }
                  },
                  onRangeSelected: (start, end, focusedDay) {
                    setState(() {
                      _selectedDay = null;
                      _focusedDay = focusedDay;
                      _rangeStart = start;
                      _rangeEnd = end;
                      _rangeSelectionMode = RangeSelectionMode.toggledOn;
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                if (_rangeStart != null &&
                    _rangeEnd != null) // Show selected range if available
                  Column(
                    children: [
                      Text(
                        'Selected Range: ${DateFormat('d MMMM').format(_rangeStart!)} to ${DateFormat('d MMMM').format(_rangeEnd!)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Days: ${_rangeEnd!.difference(_rangeStart!).inDays + 1}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.white.withOpacity(0.4))),
                      onPressed: () {
                        // Handle button press here
                      },
                      child: Text('Go Back'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color(0xffadfa00).withOpacity(0.6))),
                      onPressed: () async {
                        {
                          var fromRange =
                              (_rangeStart!.millisecondsSinceEpoch ~/ 1000)
                                  .toString();
                          var toRange =
                              (_rangeEnd!.millisecondsSinceEpoch ~/ 1000)
                                  .toString();

                          print("This is from range ${fromRange}");
                          print("This is to range ${toRange}");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Loading();
                          }));
                          try {
                            final predictedData = await ref.read(
                              getPredictDataProvider(
                                      coinName: widget.coin_id,
                                      endTime: toRange,
                                      fromTime: fromRange)
                                  .future,
                            );
                            final montlyData =
                                await ref.read(getMontlyDataProvider(
                              coinName: widget.coin_id,
                            ).future);

                            final dailyData =
                                await ref.read(getDailyDataProvider(
                              coinName: widget.coin_id,
                            ).future);

                            print("This is the predicted Data $predictedData");
                            // print("This is the montly Data $montlyData");
                            // print("This is the daily Data $dailyData");
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Charts(
                                predictedData: predictedData,
                                monthlyData: montlyData,
                                dailyData: dailyData,
                                coinId: widget.coin_id,
                              );
                            }));
                          } catch (e) {
                            print("An error occured print $e");
                          }
                        }
                        ;
                      },
                      child: Text('Predict'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

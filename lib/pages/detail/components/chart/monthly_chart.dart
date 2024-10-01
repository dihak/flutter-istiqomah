import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/models/habit.dart';

class MonthlyChart extends StatelessWidget {
  final Habit habit;

  MonthlyChart(this.habit);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xff559DFF),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          SizedBox(height: 20),
          Expanded(
            child: BarChartMonthly(habit),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Text(
      'Statistics',
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}

class BarChartMonthly extends StatefulWidget {
  final Habit habit;

  BarChartMonthly(this.habit);

  @override
  State<StatefulWidget> createState() => BarChartMonthlyState();
}

class BarChartMonthlyState extends State<BarChartMonthly> {
  final Color barBackgroundColor = themeData.primaryColor;
  final Duration animDuration = const Duration(milliseconds: 250);

  int? touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BarChart(
            mainBarData(),
            swapAnimationDuration: animDuration,
          ),
        )
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 28,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? Colors.blue[100]! : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 31,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    DateTime currentDate = new DateTime.now();
    int month = currentDate.month - 7;
    int year = currentDate.year;
    return List.generate(7, (i) {
      DateTime date = new DateTime(year, ++month);
      final double total = widget.habit.data!
          .where(
            (element) =>
                element!.indexOf(
                    '${date.year}-${date.month.toString().padLeft(2, '0')}') !=
                -1,
          )
          .length
          .toDouble();
      return makeGroupData(date.month - 1, total, isTouched: i == touchedIndex);
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      gridData: FlGridData(
        show: false,
      ),
      barTouchData: BarTouchData(
        touchCallback: (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
          setState(() {
            if (barTouchResponse?.spot != null &&
                event is! FlPanEndEvent &&
                event is! FlLongPressEnd) {
              touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                monthShortName[value.toInt()],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  height: 3,
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}

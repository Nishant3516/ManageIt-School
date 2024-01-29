import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';
import 'dart:math' as math;

class OverallAttendanceScreen extends StatelessWidget {
  static const routeName = 'OverallAttendanceScreen';
  const OverallAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final barGroups = getBarGroups();
    final averageAttendance = calculateAverageAttendance(barGroups);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overall Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.25,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 100,
                    minY: 0,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.white,
                          tooltipPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          direction: TooltipDirection.bottom,
                          tooltipBorder:
                              const BorderSide(width: 1, color: Colors.black)),
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          interval: 20,
                          showTitles: true,
                          reservedSize: 25,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          interval: 12,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final monthName = getMonthName(value.toInt() + 1);
                            return Transform.rotate(
                              angle: -math.pi / 4,
                              child: Text(
                                monthName.substring(0, 3),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey),
                    ),
                    barGroups: barGroups,
                  ),
                ),
              ),
              const YMargin(height: 20),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue[400]!,
                    width: 1,
                  ),
                ),
                child: Text(
                  'Total Attendance: ${averageAttendance.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const YMargin(),
              ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final monthName = getMonthName(index + 1);
                  final color = barGroups[index].barRods.first.color;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[350]!),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: color,
                            radius: 8,
                          ),
                          const XMargin(width: 16),
                          Expanded(
                            child: Text(
                              monthName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${barGroups[index].barRods.first.toY.toStringAsFixed(2)}%', // Representing the actual attendance percentage
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 12; i++) {
      final color = getRandomColor();
      final attendancePercentage = getRandomAttendancePercentage();
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
                toY: attendancePercentage,
                color: color,
                borderRadius: BorderRadius.circular(0)),
          ],
        ),
      );
    }
    return barGroups;
  }

  Color getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  double calculateAverageAttendance(List<BarChartGroupData> barGroups) {
    double totalAttendance = 0;
    for (var group in barGroups) {
      totalAttendance += group.barRods.first.toY;
    }
    return totalAttendance / barGroups.length;
  }

  String getMonthName(int month) {
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }

  double getRandomAttendancePercentage() {
    final random = math.Random();
    return double.parse((random.nextDouble() * 100).toStringAsFixed(2));
  }
}

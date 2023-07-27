import 'package:expand_tracker/bar_graph/Bar_Data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Mybargraph extends StatelessWidget {
  final double? maxY;
  final double? sunAmount;
  final double? monAmount;
  final double? tueAmount;
  final double? wedAmount;
  final double? thrAmount;
  final double? friAmount;
  final double? satAmount;

  const Mybargraph({
    Key? key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thrAmount,
    required this.friAmount,
    required this.satAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if any of the variables are null
    if (sunAmount == null ||
        monAmount == null ||
        tueAmount == null ||
        wedAmount == null ||
        thrAmount == null ||
        friAmount == null ||
        satAmount == null) {
      // Handle the null case, such as displaying an error message or returning an empty container
      return Container(); // You can replace this with your desired fallback UI
    }

    BarData barData = BarData(
      sunAmount: sunAmount!,
      monAmount: monAmount!,
      tueAmount: tueAmount!,
      wedAmount: wedAmount!,
      thrAmount: thrAmount!,
      friAmount: friAmount!,
      satAmount: satAmount!,
    );

    barData.intializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitle))),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: barData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.X,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, toY: maxY, color: Colors.blueGrey[100]),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'S',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

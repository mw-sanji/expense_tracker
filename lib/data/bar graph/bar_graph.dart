import 'package:expense_tracker/data/bar%20graph/bar_data.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const BarGraph(
      {super.key,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount,
      required this.maxY});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    barData.initialiseBarData();
    return BarChart(BarChartData(
        borderData:
            FlBorderData(border: Border.all(color: AllColors.primaryColor)),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitle))),
        maxY: maxY,
        minY: 0,
        barGroups: barData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      borderRadius: BorderRadius.circular(5),
                      color: AllColors.barColor,
                      width: 25,
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          color: AllColors.secondaryColor,
                          toY: maxY),
                      toY: data.y)
                ]))
            .toList()));
  }

  Widget getBottomTitle(double value, TitleMeta meta) {
    const textStyle = TextStyle(color: Colors.white);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("M", style: textStyle);
        break;
      case 1:
        text = const Text("T", style: textStyle);
        break;
      case 2:
        text = const Text("W", style: textStyle);
        break;
      case 3:
        text = const Text("T", style: textStyle);
        break;
      case 4:
        text = const Text("F", style: textStyle);
        break;
      case 5:
        text = const Text("S", style: textStyle);
        break;
      case 6:
        text = const Text("S", style: textStyle);
        break;
      default:
        text = const Text("", style: textStyle);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}

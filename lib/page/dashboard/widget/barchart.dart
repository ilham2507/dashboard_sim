import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class barchart extends StatelessWidget {
  const barchart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          borderData: FlBorderData(border: Border.all(width: 0)),
          groupsSpace: 15,
          // data dari proyek yang berjalan dirubah menjadi diagram
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 2:
                      text = Text('jan 6', style: style);
                      break;
                    case 4:
                      text = Text('jan 8', style: style);
                      break;
                    case 6:
                      text = Text('jan 10', style: style);
                      break;
                    case 8:
                      text = Text('jan 12', style: style);
                      break;
                    case 10:
                      text = Text('jan 14', style: style);
                      break;
                    case 12:
                      text = Text('jan 16', style: style);
                      break;
                    case 14:
                      text = Text('jan 18', style: style);
                      break;
                    default:
                      text = Text('', style: style);
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 16.0, // like margin
                    child: text,
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 2:
                      text = Text('25 %', style: style);
                      break;
                    case 6:
                      text = Text('50 %', style: style);
                      break;
                    case 10:
                      text = Text('75 %', style: style);
                      break;
                    case 14:
                      text = Text('100 %', style: style);
                      break;
                    default:
                      text = Text('', style: style);
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 16.0, // like margin
                    child: text,
                  );
                },
              ),
            ),
          ),
          // bottomTitles: SideTitles(
          //     showTitles: true,
          //     getTextStyles: (BuildContext, double value) => TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 12,
          //         ),
          //     margin: 16,
          //     getTitles: (double value) {
          //       if (value == 2) {
          //         return 'jan 6';
          //       }
          //       if (value == 4) {
          //         return 'jan 8';
          //       }
          //       if (value == 6) {
          //         return 'jan 10';
          //       }
          //       if (value == 8) {
          //         return 'jan 12';
          //       }
          //       if (value == 10) {
          //         return 'jan 14';
          //       }
          //       if (value == 12) {
          //         return 'jan 16';
          //       }
          //       if (value == 14) {
          //         return 'jan 18';
          //       } else {
          //         return '';
          //       }
          //     }),
          // leftTitles: SideTitles(
          //     showTitles: true,
          //     getTextStyles: (double, value) => TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 12,
          //         ),
          //     margin: 16,
          //     getTitles: (double value) {
          //       if (value == 2) {
          //         return '25 %';
          //       }
          //       if (value == 6) {
          //         return '50 %';
          //       }
          //       if (value == 10) {
          //         return '75 %';
          //       }
          //       if (value == 14) {
          //         return '100 %';
          //       } else {
          //         return '';
          //       }
          //     }),
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                  toY: 10,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  toY: 3,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                  toY: 12,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                  toY: 8,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                  toY: 6,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(
                  toY: 10,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(
                  toY: 16,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(
                  toY: 6,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 9, barRods: [
              BarChartRodData(
                  toY: 4,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 10, barRods: [
              BarChartRodData(
                  toY: 9,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 11, barRods: [
              BarChartRodData(
                  toY: 12,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 12, barRods: [
              BarChartRodData(
                  toY: 2,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 13, barRods: [
              BarChartRodData(
                  toY: 13,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
            BarChartGroupData(x: 14, barRods: [
              BarChartRodData(
                  toY: 15,
                  width: 20,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5))
            ]),
          ]),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/period.dart';

class BarGraphData {
  final String month;
  final double days;

  BarGraphData({
    required this.month,
    required this.days,
  });

  factory BarGraphData.fromPeriod(Period period) {
    // Formatting the month to be more readable (e.g., "Jan", "Feb", etc.)
    final DateFormat formatter = DateFormat('MMM');
    final String formattedMonth = formatter.format(period.from);
    final days = period.to.difference(period.from).inDays.toDouble();

    return BarGraphData(
      month: formattedMonth,
      days: days,
    );
  }
}

class CustomBarGraph extends StatelessWidget {
  final List<BarGraphData> data;

  const CustomBarGraph({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Providing more context to the axes
      primaryXAxis:  CategoryAxis(
        title: AxisTitle(text: 'Month_text'.tr()), // X Axis title
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Days_text'.tr()), // Y Axis title
        numberFormat: NumberFormat("## 'Days'"), // Formatting Y Axis labels
        interval: 1, // Adjust based on your data's range
      ),
      series: <CartesianSeries>[
        BarSeries<BarGraphData, String>(
          dataSource: data,
          xValueMapper: (BarGraphData barData, _) => barData.month,
          yValueMapper: (BarGraphData barData, _) => barData.days,
          name: 'Menstrual_Cycle_Length'.tr(),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true, // Show data labels
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(fontSize: 10), // Smaller text for readability
          ),
        ),
      ],
      // Enhanced tooltip behavior for better clarity
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
        format: 'Month: point.x\nDays: point.y',
      ),
      // Legend settings for clarity
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
    );
  }
}

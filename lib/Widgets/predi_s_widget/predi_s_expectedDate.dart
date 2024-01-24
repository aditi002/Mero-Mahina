import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mero_mahinaa/model/period.dart';
import 'package:mero_mahinaa/model/prediction.dart';
import 'package:mero_mahinaa/provider/period_provider.dart';
import 'package:mero_mahinaa/service/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;


class ExpectedDate extends StatefulWidget {
  const ExpectedDate({Key? key}) : super(key: key);

  @override
  State<ExpectedDate> createState() => _ExpectedDateState();
}

class _ExpectedDateState extends State<ExpectedDate> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Period>>(
      future: Provider.of<PeriodProvider>(context, listen: false).getPeriodList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Error or no data'.tr()));
        }

        List<Period> periodList = snapshot.data!;
        if (periodList.length > 1) {
          final prediction = _calculatePrediction(periodList);

          // Schedule notification for the predicted alert date
          _scheduleNotification(prediction.alertDate, 'Period Alert', "Your next period is predicted to start on ${intl.DateFormat('yyyy-MM-dd').format(prediction.alertDate)}.");
          NotificationService.showWearNotification();
          return _buildPredictionDisplay(prediction.ovulationDate, prediction.alertDate);
        } else {
          return Center(child: Text('Not enough data for prediction'.tr()));
        }
      },
    );
  }

  void _scheduleNotification(DateTime scheduledDate, String title, String body) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Period Alert',
      channelDescription: 'Notification channel for period alert',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  
    );
  }

  Prediction _calculatePrediction(List<Period> periodList) {
    DateTime lastPeriodDate = periodList.last.to;
    int averageCycleLength = 28; // Simplified for example purposes
    DateTime ovulationDate = lastPeriodDate.add(const Duration(days: 14));
    DateTime alertDate = lastPeriodDate.add(Duration(days: averageCycleLength));

    return Prediction(ovulationDate: ovulationDate, alertDate: alertDate);
  }

  Widget _buildPredictionDisplay(DateTime ovulationDate, DateTime alertDate) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Predictions',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        _dateInfoContainer('Ovulation Date', ovulationDate, Colors.amber),
        _dateInfoContainer('Alert Date', alertDate, Colors.lightBlue),
      ],
    );
  }

  Widget _dateInfoContainer(String title, DateTime date, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            intl.DateFormat('yyyy-MM-dd EEE').format(date),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}



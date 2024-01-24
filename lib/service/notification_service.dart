import 'package:flutter/services.dart';

class NotificationService {
  static const platform = MethodChannel('com.example.mero_mahinaa.notifications');

  static Future<void> showWearNotification() async {
    try {
      await platform.invokeMethod('showEnhancedNotification', <String, dynamic>{
        'title': 'Period Alert!',
        'message': 'This is your period alert.',
      });
    } on PlatformException catch (e) {
      print("Failed to invoke method: ${e.message}");
    }
  }
}

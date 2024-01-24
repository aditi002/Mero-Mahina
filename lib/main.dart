import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_mahinaa/Screen/login/mainScreen.dart';
import 'package:mero_mahinaa/api/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import './main_properties/provider_list.dart';
import './main_properties/theme.dart';
import 'Screen/Home/home_screen.dart';
import 'main_properties/routs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await EasyLocalization.ensureInitialized();
  initializeNotifications(); 
  tz.initializeTimeZones(); 
  runApp(EasyLocalization(supportedLocales:const [
    Locale('en', 'US'),
    Locale('ne','NE')
  ], path: 'assets/translation', child: const MyApp()) );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: MaterialApp(
        title: 'Mero_Mahina'.tr(),
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates:context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            ScreenUtil.init(
              context,
            );
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const MainScreen();
            }
          },
        ),

        routes: routeTable,
      ),
    );
  }
}

// Initialize FlutterLocalNotificationsPlugin in the main function
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() async{
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,

  );
}

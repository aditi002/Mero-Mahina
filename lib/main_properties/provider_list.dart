import 'package:mero_mahinaa/provider/auth_provider.dart';
import 'package:mero_mahinaa/provider/emergency_doctor_provider.dart';
import 'package:mero_mahinaa/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../provider/period_provider.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider(
    create: (context) => Auth(),
  ),
  ChangeNotifierProvider(
    create: (context) => PeriodProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmergencyDoctorProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProfileProvider(),
  ),
  // ChangeNotifierProvider(
  //   create: (context) => LanguageProvider(),
  // ),
];

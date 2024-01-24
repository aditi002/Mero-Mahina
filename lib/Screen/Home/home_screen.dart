import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/Screen/DoctorList/doctor_list_screen.dart';
import 'package:mero_mahinaa/Screen/NewPeriod/add_period_screen.dart';
import 'package:mero_mahinaa/Screen/Prediction/prediction_screen.dart';
import 'package:mero_mahinaa/Screen/Profile/profile_screen.dart';
import 'package:mero_mahinaa/Screen/Recomended/recomended_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: selectedPageIndex == 2
          ? const ProfileScreen()
          : selectedPageIndex == 0
              ? const PredictionScreen()
              : selectedPageIndex == 1
                  ? RecomendedScreen()
                  : selectedPageIndex == 3
                      ? DoctorListScreen()
                      : null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 255, 0, 72),
        unselectedItemColor: const Color.fromARGB(255, 255, 0, 72),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.date_range),
            label: 'Prediction_text'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.recommend),
            label: 'Recommendations_text'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_sharp),
            label: 'Profile_text'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.medical_services),
            label: 'Doctors_text'.tr(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPeriodScreen.routeName);
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/Screen/Profile/add_emergency_doctor.dart';

class EmergencyDocCard extends StatelessWidget {
  const EmergencyDocCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 150,
      width: 350,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 5,
          colors: [
            Colors.red[50] ?? Colors.transparent,
            Colors.red[400] ?? Colors.transparent,
            Colors.red[900] ?? Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Add_Emergency_Doctor_Details".tr(),
            style: const TextStyle(fontSize: 18),
          ),
          OutlinedButton(
            child: Text("Add_text".tr()),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEmergencyDoctor.routeName);
            },
          )
        ],
      ),
    );
  }
}

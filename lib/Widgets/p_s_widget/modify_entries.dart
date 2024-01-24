import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Screen/Profile/modify_entries_screen.dart';

class ModifyEntries extends StatelessWidget {
  const ModifyEntries({super.key});

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
            "Updated_Period_Details".tr(),
            style: TextStyle(fontSize: 18),
          ),
          OutlinedButton(
            child: Text("View_text".tr()),
            onPressed: () {
              Navigator.of(context).pushNamed(ModifyScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}

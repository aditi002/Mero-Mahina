import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/emergencyDoctor.dart';

class EmergencyDoctorProvider with ChangeNotifier {
  void addDoc({
  BuildContext? ctx,
  required String name,
  required int mob,
  required String mail,
}) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    // Sending message to Realtime Database
    await FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(user!.uid)
        .child("doctor")
        .push()
        .set({
      "name": name,
      "mob": mob,
      "mail": mail,
    });

    print("Emergency Doctor stored");
    notifyListeners(); // Notify listeners after adding a new doctor
  } catch (err) {
    print("Error in period provider");
    print(err);
  }
}


 Future<List<EmegencyDoctor>> getEmergencyDoctors() async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    // Fetching data from Realtime Database
    final dataSnapshot = await FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(user!.uid)
        .child("doctor")
        .once();

    final data = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      print("Getting emergency doctors from Realtime Database");

      List<EmegencyDoctor> emergencyDoctors = [];

      data.forEach((key, value) {
        emergencyDoctors.add(EmegencyDoctor(
          name: value['name'],
          phone: value['mob'],
          email: value['mail'],
        ));
      });

      return emergencyDoctors;
    } else {
      // Handle the case where no data is found
      throw Exception("No emergency doctor data found");
    }
  } catch (err) {
    print(err);
    // Rethrow the exception to be handled by the caller
    throw Exception("Failed to get emergency doctors");
  }
}

}

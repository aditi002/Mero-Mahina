import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/home_screen/h_s_BarGraphData.dart';
import 'package:mero_mahinaa/model/period.dart';

import '../model/profile.dart';

class ProfileProvider with ChangeNotifier {
  Future<List<BarGraphData>> getBarGraphData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userReference =
          FirebaseDatabase.instance.ref().child('users').child(user!.uid);

      // Fetching data from Realtime Database
      DataSnapshot dataSnapshot = (await userReference.once()).snapshot;

      // Print the raw data
      print('Raw data from Firebase: ${dataSnapshot.value}');

      // Extract periods from the data
      List<Period> periods = [];
      if (dataSnapshot.value != null && dataSnapshot.value is Map) {
        Map<dynamic, dynamic> data =
            dataSnapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          if (value is Map) {
            periods.add(Period.fromJson(value.cast<String, dynamic>()));
          }
        });

        // Print the extracted periods
        print('Extracted Periods: $periods');
      }

      // Convert periods to BarGraphData
      List<BarGraphData> barGraphData = periods.map((period) {
        return BarGraphData.fromPeriod(period);
      }).toList();

      // Print the converted BarGraphData
      print('Converted BarGraphData: $barGraphData');

      return barGraphData;
    } catch (err) {
      print(err);
      throw Exception("Failed to get bar graph data");
    }
  }

  // ProfileProvider
Future<Profile?> getProfile() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    final userReference =
        FirebaseDatabase.instance.ref().child('users').child(user!.uid);

    // Fetching data from Realtime Database
    DataSnapshot dataSnapshot = (await userReference.once()).snapshot;

    // Check if dataSnapshot.value is not null and is of type Map
    if (dataSnapshot.value != null && dataSnapshot.value is Map) {
      Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;

      print("Getting Profile from Realtime Database");
      print(data['email']);
      
      // Use ISO 8601 format for consistent parsing
      print(DateTime.tryParse(data['dob'] ?? ''));
      
      // Parse 'mobile' as String or set it to an empty string if not present
      print(data['mobile'] is String ? data['mobile'] : '');

      print(data['name']);
      print(data['username']);

      // Check if data is not null before creating Profile object
      Profile fetchProfile = Profile(
        name: data['name'] ?? '',
         phone: data['mobile'] != null
            ? int.tryParse(data['mobile'].toString()) ?? 0
            : 0,
        email: data['email'] ?? '',
        dob: DateTime.tryParse(data['dob'] ?? '') ?? DateTime.now(),
        userName: data['username'] ?? '',
      );
      return fetchProfile;
    } else {
      return null;
    }
  } catch (err) {
    print(err);
    throw Exception("Failed to get profile");
  }
}

}

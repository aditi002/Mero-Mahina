import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/period.dart';

class PeriodProvider with ChangeNotifier {
  late List<Period> periodListFetchedAlready;

  Future<void> addPeriod({
    required String from,
    required String to,
    required int pain,
    required int blood,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userReference = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user!.uid)
          .child("Period");

      await userReference.push().set({
        "from": from,
        "to": to,
        "blood": blood,
        "pain": pain,
      });

      print("Period added successfully");
      notifyListeners(); 
    } catch (error) {
      print("Error in period provider");
      print(error);
      rethrow;
    }
  }

  Future<List<Period>> getPeriodList() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userReference = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user!.uid)
          .child("Period");

      final dataSnapshot = await userReference.once();
      final data = dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      print("Getting Profile from Realtime Database");
      if (data != null) {
        print("Getting period list from Realtime Database");

        List<Period> periodList = data.entries
            .map((entry) => Period(
                  bloodIndex: entry.value['blood'],
                  from: DateTime.parse(entry.value['from']),
                  painIndex: entry.value['pain'],
                  to: DateTime.parse(entry.value['to']),
                ))
            .toList();

        periodListFetchedAlready = periodList;
        return periodList;
      }

      return [];
    } catch (error) {
      print(error);
      throw Exception("Failed to get period list");
    }
  }

  List<Period> periodListProvideFromAlreadyFetched() {
    return periodListFetchedAlready;
  }
  Period? getMostRecentPeriod() {
  if (periodListFetchedAlready.isEmpty) {
    return null;
  }
  periodListFetchedAlready.sort((a, b) => b.from.compareTo(a.from)); 
  return periodListFetchedAlready.first;
}
  DateTime calculateNextPeriodStart(DateTime lastPeriodStart, {int cycleLength = 28}) {
  return lastPeriodStart.add(Duration(days: cycleLength));
}

DateTime calculateOvulationDay(DateTime lastPeriodStart, {int cycleLength = 28}) {

  return calculateNextPeriodStart(lastPeriodStart, cycleLength: cycleLength).subtract(const Duration(days: 14));
}

}


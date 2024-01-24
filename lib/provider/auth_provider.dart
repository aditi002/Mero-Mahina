import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  late UserCredential authResult;

  Future<void> inputUserDetails({
    required String name,
    required String userName,
    required String dob,
    required int mob,
    required BuildContext ctx,
    required String uid,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        final userReference = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(currentUser.uid);

        await userReference.update({
          'name': name,
          'username': userName,
          'dob': dob,
          'mobile': mob,
        });

        Navigator.of(ctx)
            .popUntil((route) => route.isFirst); 
        print("User Details Updated Successfully");
      } on PlatformException catch (error) {
        print("PlatformException caught: $error");
        String? message = "An error occurred, Please check your credentials!";
        if (error.message != null) {
          message = error.message;
        }
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message ?? "Default Message"),
            backgroundColor: Theme.of(ctx).colorScheme.error,
          ),
        );
      } catch (error) {
        print("Error in Auth provider while saving details: $error");
      }
    } else {
      print("Current user is null");
      // Handle the case where the current user is null
    }
  }

  Future<void> submitAuthForm({
    required String email,
    required String userName,
    required String password,
    required bool isLogin,
    required BuildContext ctx,
  }) async {
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(ctx).pop();
        print("Login Successful");
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (authResult.user != null) {
          final userReference = FirebaseDatabase.instance
              .ref()
              .child('users')
              .child(authResult.user!.uid);

          await userReference.set({
            'username': userName,
            'email': email,
          });

          print("SignUp Successful");
        } else {
          print("User not found in authResult after signup");
          // Handle the case where user is null in authResult
        }
      }
    } on PlatformException catch (error) {
      String? message = "An error occurred, Please check your credentials!";
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message ?? "Default Message"),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
    } catch (error) {
      print("Error in auth provider");
      print(error);
    }
    notifyListeners();
  }
}

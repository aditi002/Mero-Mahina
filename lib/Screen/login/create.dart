import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mero_mahinaa/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import './details.dart';
// import 'package:email_validator/email_validator.dart';

class CreateScreen extends StatelessWidget {
  static const routeName = 'Signup';
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  CreateScreen({super.key});

  void onSaved(BuildContext context) {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Provider.of<Auth>(context, listen: false).submitAuthForm(
        ctx: context,
        email: usernameController.text,
        password: passwordController.text,
        isLogin: false, userName: '',
      );
      Navigator.of(context).pushNamed(DetailScreen.routeName);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // final bool sas = usernameController.text.isEmpty;
    return Scaffold(
        appBar: AppBar(
          title:  Text("SignUp_text".tr()),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 250,
                  child: SvgPicture.asset(
                    'assets/images/medicine_b1ol.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          decoration:  InputDecoration(
                            labelText: 'Email_text'.tr(),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: usernameController,
                        ),
                        TextField(
                          obscureText: true,
                          decoration:  InputDecoration(
                            labelText: 'Password_text'.tr(),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                          controller: passwordController,
                        ),
                        TextField(
                          obscureText: true,
                          decoration:  InputDecoration(
                            labelText: 'Confirm_Password_text'.tr(),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                          controller: confirmController,
                        ),
                        Builder(
                          builder: (context) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 255, 255, 255), backgroundColor: const Color.fromARGB(255, 255, 0, 157), // Set the text (foreground) color here
                              ),
                              onPressed: () {
                                // if (sas == false) {
                                if (confirmController.text ==
                                        passwordController.text &&
                                    confirmController.text.isNotEmpty) {
                                  onSaved(context);
                                } else {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      content: Text(
                                          'Confirmed_Password_is_not_matched_text'.tr()),
                                    ),
                                  );
                                }
                              },
                              child:  Text('signup_button_text'.tr()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

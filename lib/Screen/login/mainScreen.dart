import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create.dart';
import 'login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          PopupMenuButton<int>(
            onSelected: (result) {
              if (result == 0) {
                context.setLocale(const Locale('en', 'US'));
              } else if (result == 1) {
                context.setLocale(const Locale('ne', 'NE'));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('English'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Nepali'),
              ),
            ],
            icon: const Icon(Icons.language, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Card(
                child: Text(
                  'Mero_Mahina'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 44, 65),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              Card(
                child: Text(
                  "One_cycle_at_a_time".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 7, 106),
                    fontSize: 20,
                    wordSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: SvgPicture.asset('assets/images/Untitled design.svg'),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child:  Text(
                          'Login_text'.tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(5),
                      child:  Center(
                        child: Text(
                          'Or_text'.tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Color.fromARGB(0, 50, 100, 50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          'Create_an_account'.tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CreateScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

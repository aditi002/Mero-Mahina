import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mero_mahinaa/provider/auth_provider.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _isLoading = false;
  final userController = TextEditingController();

  final passController = TextEditingController();

  void onSaved(BuildContext context) {
    if (userController.text.isNotEmpty && passController.text.isNotEmpty) {
      Provider.of<Auth>(context, listen: false).submitAuthForm(
        ctx: context,
        email: userController.text,
        password: passController.text,
        isLogin: true, userName: '',
      );
      print(userController.text);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Login_Screen_text".tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: SvgPicture.asset(
                'assets/images/my_password_d6kg.svg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration:  InputDecoration(
                          labelText: 'Email_text'.tr(),
                          prefixIcon: const Icon(Icons.account_circle),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: userController,
                      ),
                      TextField(
                        obscureText: true,
                        decoration:  InputDecoration(
                          labelText: 'Password_text'.tr(),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        controller: passController,
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                onSaved(context);
                                // Navigator.of(context)
                                //     .pushNamed(HomeScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                                backgroundColor: const Color.fromARGB(255, 255, 0, 157), 
                              ),
                              child: Text('login_button_text'.tr()),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

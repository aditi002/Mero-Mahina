import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mero_mahinaa/provider/auth_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  static const routeName = 'details';
  final format = DateFormat("yyyy-MM-dd");

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final number = TextEditingController();
  late DateTime dob;

  DetailScreen({super.key});

  // DetailScreen
  void _saveForm(BuildContext context) {
    print("tapped");

    // nameController.text.isNotEmpty &&
    //   usernameController.text.isNotEmpty &&
    //   number.text.isNotEmpty &&
    //   dob != null

    print(nameController.text);

    // Save date as ISO 8601 formatted string
    print(dob.toIso8601String());

    print(usernameController.text);
    print(int.parse(number.text));

    Provider.of<Auth>(context, listen: false).inputUserDetails(
      name: nameController.text,
      userName: usernameController.text,
      ctx: context,
      dob: dob.toIso8601String(),
      mob: int.parse(number.text),
      uid: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Info_text".tr()),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                child: SvgPicture.asset('assets/images/4.svg'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 3,
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Name_text'.tr(),
                      ),
                      controller: nameController,
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'UserName_text'.tr(),
                      ),
                      controller: usernameController,
                    ),
                  ),
                  Card(
                      elevation: 3,
                      child: DateTimeField(
                        format: format,
                        decoration: InputDecoration(
                          labelText: "Date_Of_Birth_text".tr(),
                        ),
                        initialValue: null,
                        onShowPicker: (context, currentValueCFrom) async {
                          // Remove the initialization of currentValueCFrom
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1960),
                            initialDate: currentValueCFrom ??
                                DateTime.now(), // Use null-aware operator
                            lastDate: DateTime.now(),
                          );
                          dob = date!;
                          print(date);
                          return date;
                        },
                      )),
                  Card(
                    elevation: 3,
                    child: TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Mobile_Number_text'.tr(),
                      ),
                      keyboardType: TextInputType.number,
                      controller: number,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label:  Text(
          "Save_text".tr(),
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          _saveForm(context);
        },
      ),
    );
  }
}

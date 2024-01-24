import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/provider/emergency_doctor_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddEmergencyDoctor extends StatelessWidget {
  static const routeName = '/emergency-doctor';

  final _formKey = GlobalKey<FormState>();
  var name = '';
  var phone = 0;
  var mail = '';

  AddEmergencyDoctor({super.key});

  void _saveForm(
    BuildContext context,
  ) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      print(name);
      print(phone);
      print(mail);
      Provider.of<EmergencyDoctorProvider>(context, listen: false).addDoc(
        ctx: context,
        mail: mail,
        mob: phone,
        name: name,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showFloating = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Emergency_Doctor_Details_text".tr()),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: "",
                              decoration: InputDecoration(
                                labelText: "Doctors_Full_Name_text".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Please_provide_Doctor_name_text".tr();
                                }
                              },
                              onSaved: (value) {
                                name = value!;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: "",
                              decoration: InputDecoration(
                                labelText: "Contact_Number_text".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length >= 10) {
                                  return null;
                                } else {
                                  return "Enter_Doctors_Contact_Details_text".tr();
                                }
                              },
                              onSaved: (value) {
                                phone = int.parse(value!);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: "",
                              decoration: InputDecoration(
                                labelText: "Email_text".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Enter_Valid_Email_Address".tr();
                                }
                              },
                              onSaved: (value) {
                                mail = value!;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showFloating
          ? FloatingActionButton.extended(
              label:  Text(
                "Save_text".tr(),
                style: const TextStyle(color: Colors.black),
              ),
              isExtended: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                _saveForm(context);
              },
            )
          : null,
    );
  }
}

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_mahinaa/Constant/colors.dart';
import 'package:mero_mahinaa/provider/period_provider.dart';
import 'package:provider/provider.dart';

import '../../Widgets/n_p_widget/n_p_heavyBleed.dart';
import '../../Widgets/n_p_widget/n_p_pain.dart';

// ignore: must_be_immutable
class AddPeriodScreen extends StatelessWidget {
  static const routeName = "add-Period";
  final format = DateFormat("yyyy-MM-dd hh:mm a");
  late DateTime from;
  late DateTime to;
  int painIndex = 0;
  int bloodIndex = 0;

  AddPeriodScreen({super.key});

  void painCallback(int painIndex) {
    painIndex = painIndex;
  }

  void bloodCallback(int bloodIndex) {
    bloodIndex = bloodIndex;
  }

  void _saveForm(BuildContext context) async {
    print(painIndex);
    print(bloodIndex);
    print(from);
    print(to);
    Provider.of<PeriodProvider>(context, listen: false).addPeriod(
      blood: bloodIndex,
      pain: painIndex,
      from: from.toIso8601String(),
      to: to.toIso8601String(),
    );
    print("Requesting to add period ");
    Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Title("Last_cycle_text".tr(),
                  Icons.calendar_month),
              const SizedBox(height: 10),
              SizedBox(
                width: 0.95.sw,
                child: DateTimeField(
                  format: format,
                  decoration: InputDecoration(
                    labelText: "from_text".tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  initialValue: null,
                  onShowPicker: (context, currentValueCFrom) async {
                    currentValueCFrom = DateTime.now();
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      initialDate: currentValueCFrom,
                      lastDate: DateTime(2025),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValueCFrom),
                      );

                      from = DateTimeField.combine(date, time);
                      return DateTimeField.combine(date, time);
                    } else {
                      from = currentValueCFrom;
                      return currentValueCFrom;
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 0.95.sw,
                child: DateTimeField(
                  format: format,
                  decoration: InputDecoration(
                    labelText: "To_text".tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  initialValue: null,
                  onShowPicker: (context, currentValueTTo) async {
                    currentValueTTo = DateTime.now();
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      initialDate: currentValueTTo,
                      lastDate: DateTime(2025),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValueTTo),
                      );

                      to = DateTimeField.combine(date, time);
                      return DateTimeField.combine(date, time);
                    } else {
                      to = currentValueTTo;
                      return currentValueTTo;
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Title("heavy_bleeding_text".tr(), Icons.arrow_drop_down_circle_outlined),
              NPHeavyBleed(bloodCallback),
              Title("How_pain_text".tr(), Icons.question_answer),
              NPPain(painCallback),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Save_text".tr(),
          style: TextStyle(color: Colors.black),
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

class Title extends StatelessWidget {
  final title;
  final icon;

  const Title(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const PainIntensity = ["High", "Moderate", "Low"];

/// This is the stateful widget that the main application instantiates.
class NPPain extends StatefulWidget {
  final Function painCallback;
  NPPain(this.painCallback);

  @override
  _NPPainState createState() => _NPPainState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NPPainState extends State<NPPain> {
  var _character = PainIntensity[0];

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text('High_text'.tr()),
              Radio(
                value: PainIntensity.elementAt(0),
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character =
                        value ?? ""; // Use an empty string if value is null
                  });
                  widget.painCallback(0);
                  print(_character);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Moderate_text'.tr()),
              Radio(
                value: PainIntensity.elementAt(1),
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character =
                        value ?? ""; // Use an empty string if value is null
                  });
                  widget.painCallback(0);
                  print(_character);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Low_text'.tr()),
              Radio(
                value: PainIntensity.elementAt(2),
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character =
                        value ?? ""; // Use an empty string if value is null
                  });
                  widget.painCallback(0);
                  print(_character);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mero_mahinaa/model/profile.dart';


class PSEmailPhoneCard extends StatelessWidget {
  final Profile profileDetails;

  const PSEmailPhoneCard(this.profileDetails, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(profileDetails.email)
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      "${(DateTime.now().difference(profileDetails.dob).inDays / 365.25).floor()} Years Old",
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

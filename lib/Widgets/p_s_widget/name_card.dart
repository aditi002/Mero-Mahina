import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mero_mahinaa/model/profile.dart';


class PSPicNameListTile extends StatelessWidget {
  final Profile profileDetails;

  const PSPicNameListTile(this.profileDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 70,
        child: Hero(
          tag: "ProfileHeroKey",
          child: ClipOval(
              child: SvgPicture.asset(
            "assets/images/4.svg",
          )),
        ),
      ),
      title: Text(
        profileDetails.name,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        profileDetails.userName,
      ),
    );
  }
}

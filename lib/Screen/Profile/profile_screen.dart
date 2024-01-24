import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/Constant/colors.dart';
import 'package:mero_mahinaa/model/profile.dart';
import 'package:mero_mahinaa/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../Widgets/p_s_widget/email_age.dart';
import '../../Widgets/p_s_widget/emergency_doc_card.dart';
import '../../Widgets/p_s_widget/modify_entries.dart';
import '../../Widgets/p_s_widget/name_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
  future: Provider.of<ProfileProvider>(context).getProfile(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Loading indicator while waiting for the future to complete
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      // Handle the error case
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.data is Profile) {
      // Data is available, proceed with building the UI
      Profile profile = snapshot.data as Profile;

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
          backgroundColor: appBarColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PSPicNameListTile(profile),
              const SizedBox(height: 10),
              PSEmailPhoneCard(profile),
              const SizedBox(height: 20),
              ModifyEntries(),
              const SizedBox(height: 20),
              const EmergencyDocCard(),
            ],
          ),
        ),
      );
    } else {
      // Handle the case when the data is not of type Profile
      return  Center(child: Text('Invalid_data_type_text'.tr()));
    }
  },
);

  }
}

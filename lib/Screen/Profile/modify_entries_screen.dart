import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mero_mahinaa/model/period.dart';
import 'package:mero_mahinaa/provider/period_provider.dart';
import 'package:provider/provider.dart';

class ModifyScreen extends StatelessWidget {
  static const routeName = 'modify-screen';
  static const BleedingIntensity = ["Heavy", "Normal", "Low"];
  static const PainIntensity = ["High", "Moderate", "Low"];

  const ModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<PeriodProvider>(context, listen: false).getPeriodList(),
      builder: (context, AsyncSnapshot<List<Period>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}".tr()));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text("No_data_available_text".tr()));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("List_All_entries_text".tr()),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final period = snapshot.data![index];
                // Use DateFormat with context.locale for localization
                String formattedFrom = DateFormat('yyyy-MM-dd EE', context.locale.toString()).format(period.from);
                String formattedTo = DateFormat('yyyy-MM-dd EE', context.locale.toString()).format(period.to);
                return Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        "$formattedFrom to $formattedTo",
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "${"Pain_text".tr()}: ${BleedingIntensity[period.painIndex]}",
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${"Bleeding_text".tr()}: ${PainIntensity[period.bloodIndex]}",
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}

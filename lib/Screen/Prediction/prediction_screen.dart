import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_mahinaa/home_screen/h_s_BarGraphData.dart';
import 'package:mero_mahinaa/model/period.dart';
import 'package:mero_mahinaa/provider/period_provider.dart'; // Correct import for your PeriodProvider
import 'package:provider/provider.dart';


class PredictionScreen extends StatelessWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              FutureBuilder<List<Period>>(
                future: Provider.of<PeriodProvider>(context, listen: false).getPeriodList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error_fetching_data_text'.tr()));
                  } else if (!snapshot.hasData || (snapshot.data as List<Period>).isEmpty) {
                    return Center(child: Text('No_data_text'.tr()));
                  } else {
                    List<Period> periodList = snapshot.data!;
                    DateTime lastPeriodStart = periodList.last.from; 
                    int averageCycleLength = 28;
                    
                    DateTime ovulationDay = lastPeriodStart.add(Duration(days: 14)); 
                    DateTime periodAlertDay = lastPeriodStart.add(Duration(days: averageCycleLength));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Expected_text".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ExpectedDate(
                          ovulationDay: ovulationDay,
                          alertDay: periodAlertDay,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Statistics_text".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "bar_text_1".tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Your CustomBarGraph widget
                        CustomBarGraph(data: periodList.map((e) => BarGraphData.fromPeriod(e)).toList()),
                        SizedBox(height: 20.h),
                        Text(
                          "Understanding_Your_Cycle".tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.blue[800],
                          ),
                        ),
                        Text(
                          "Your_cycle".tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ExpectedDate extends StatelessWidget {
  final DateTime ovulationDay;
  final DateTime alertDay;

  const ExpectedDate({
    Key? key,
    required this.ovulationDay,
    required this.alertDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _dateInfoContainer('Ovulation_Day'.tr(), ovulationDay, Colors.amber),
        _dateInfoContainer('Period_Alert_Day'.tr(), alertDay, Colors.lightBlue),
      ],
    );
  }

  Widget _dateInfoContainer(String title, DateTime date, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: bgColor,
      child: Column(
        children: [
          Text(
            title.tr(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat('yyyy-MM-dd').format(date),
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

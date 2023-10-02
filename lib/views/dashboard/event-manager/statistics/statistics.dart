import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/models/show-events-model.dart';
import 'package:nomad/models/message-model.dart';
import 'package:nomad/models/nearby-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/event-manager/statistics/widgets/bar_chart.dart';
import 'package:nomad/views/dashboard/messages/search-messages/searchMessages.dart';
import 'package:nomad/views/dashboard/notifications/notification.dart';
import 'package:nomad/views/initial-screens/add-profile-pic/profilePic.dart';
import 'package:nomad/views/initial-screens/login/login.dart';
import 'package:nomad/views/initial-screens/otp-screen/otpSecreen.dart';
import 'package:nomad/views/initial-screens/scan-passport/fill-in-data/fillData.dart';
import 'package:nomad/views/initial-screens/scan-passport/scanPassport.dart';
import 'package:nomad/views/initial-screens/terms-of-service/termsOfService.dart';
import 'package:nomad/views/payment-section/subscription/activaSubscription.dart';
import 'package:nomad/views/payment-section/success/paymentSuccess.dart';
import 'package:nomad/views/profile/profile.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KConstant.colorA,
        title: Text(
          "Statistics",
        ),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(KConstant.backWhiteButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                MyBarChart(),
                Center(
                    child: SfCircularChart(
                        title: ChartTitle(text: 'Users stats'),
                        legend: Legend(isVisible: true),
                        series: <PieSeries<_PieData, String>>[
                      PieSeries<_PieData, String>(
                          explode: true,
                          explodeIndex: 0,
                          dataSource: pieData,
                          xValueMapper: (_PieData data, _) => data.xData,
                          yValueMapper: (_PieData data, _) => data.yData,
                          dataLabelMapper: (_PieData data, _) => data.text,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [colorA, colorB],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border.all(
                            color: Colors.red.shade500,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              "52%",
                              style: white30Style(),
                            ),
                            Text(
                              "Active Users",
                              style: white15Style(),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [colorA, colorB],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border.all(
                            color: Colors.red.shade500,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              "48%",
                              style: white30Style(),
                            ),
                            Text(
                              "InActive Users",
                              style: white15Style(),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  List<_PieData> pieData = [
    _PieData('Active Users', 5000),
    _PieData('InActive Users', 350),
  ];
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;
  final String? text;
}

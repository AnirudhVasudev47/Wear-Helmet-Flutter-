import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/services/authentication.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController animationController;
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('users');

  Future<String> getData() async => reference
          .child(currentUser)
          .child('kilometer')
          .once()
          .then((DataSnapshot snapshot) {
        return snapshot.value.toString();
      });

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      lowerBound: 0,
      upperBound: 110,
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = new ScreenUtil();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: screenUtil.setWidth(24),
              top: screenUtil.setHeight(32),
            ),
            child: Text(
              'Status',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(32),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenUtil.setWidth(24),
            ),
            padding: EdgeInsets.symmetric(vertical: screenUtil.setHeight(24)),
            decoration: BoxDecoration(
              color: Color(0xfffdfdfd),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffe7e7e7),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: screenUtil.setWidth(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Points earned',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Today',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: screenUtil.setHeight(24),
                          ),
                          FutureBuilder(
                            future: getData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot.data);
                                return Text(
                                  '${snapshot.data} pts',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26.sp,
                                  ),
                                  textAlign: TextAlign.start,
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: screenUtil.setWidth(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: screenUtil.setHeight(104),
                        width: screenUtil.setWidth(104),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffebd2ff),
                        ),
                      ),
                      FutureBuilder(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return Container(
                              height: screenUtil.setHeight(122),
                              width: screenUtil.setWidth(122),
                              child: SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    annotations: [
                                      GaugeAnnotation(
                                        widget: Text(
                                          snapshot.data + " KMS",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                    minimum: 0,
                                    maximum: 100,
                                    pointers: [
                                      RangePointer(
                                          value:
                                              double.parse(snapshot.data) + 10,
                                          cornerStyle: CornerStyle.bothCurve,
                                          color: Color(0xff9d4edd)),
                                    ],
                                    showLabels: false,
                                    showTicks: false,
                                    axisLineStyle: AxisLineStyle(
                                      thickness: 0.17,
                                      cornerStyle: CornerStyle.bothCurve,
                                      color: Color(0xff240046),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return AnimatedBuilder(
                            animation: animationController,
                            builder: (context, child) {
                              return Container(
                                height: screenUtil.setHeight(122),
                                width: screenUtil.setWidth(122),
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 110,
                                      pointers: [
                                        RangePointer(
                                            value: (animationController.value),
                                            cornerStyle: CornerStyle.bothCurve,
                                            color: Color(0xff9d4edd)),
                                      ],
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: AxisLineStyle(
                                        thickness: 0.17,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: Color(0xff240046),
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(32),
          ),
          Container(
            padding: EdgeInsets.only(
              left: screenUtil.setWidth(24),
            ),
            child: Text(
              'Start Ride',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(36),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenUtil.setHeight(24),
            ),
            // child: ,
          ),
        ],
      ),
    );
  }
}

/*
Container(
                                height: screenUtil.setHeight(122),
                                width: screenUtil.setWidth(122),
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 110,
                                      pointers: [
                                        RangePointer(
                                            value: value,
                                            cornerStyle: CornerStyle.bothCurve,
                                            color: Color(0xff9d4edd)),
                                      ],
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: AxisLineStyle(
                                        thickness: 0.17,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: Color(0xff240046),
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
 */

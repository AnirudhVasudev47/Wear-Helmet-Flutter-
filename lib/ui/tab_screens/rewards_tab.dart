import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/ui/widget/rewards_card.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({Key? key}) : super(key: key);

  @override
  _RewardsTabState createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('rewards');
  bool status = false;

  Future<DataSnapshot> getData() async => reference
          .child(currentUser)
          .child('kilometer')
          .once()
          .then((DataSnapshot snapshot) {
        return snapshot;
      });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = new ScreenUtil();
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: screenUtil.setWidth(24),
              top: screenUtil.setHeight(32),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Rewards',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: reference.onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  Event? rewards = snapshot.data;

                  return Container(
                    padding: EdgeInsets.only(top: screenUtil.setHeight(32)),
                    child: Column(
                      children: [
                        RewardsCard(
                          imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/wear-helmet-app.appspot.com/o/images%2F669505d1-fec6-4aef-957c-374a44ff0a8a.png?alt=media&token=00ebb8d8-a503-4c9d-944a-353613aefe8d',
                          name: 'Hues Glam',
                          desc: "Get your make up done with great detailing.",
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

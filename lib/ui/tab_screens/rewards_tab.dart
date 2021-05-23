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
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenUtil.setWidth(24),
              ).copyWith(top: screenUtil.setHeight(32)),
              child: FirebaseAnimatedList(
                query: reference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return RewardsCard(
                    imageUrl: snapshot.value['storeBanner'],
                    name: snapshot.value['storeName'],
                    desc: snapshot.value['storeDesc'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
StreamBuilder(
              stream: reference.onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  Event? rewards = snapshot.data;
                  print(rewards!.snapshot.value);
                  List<Store> store = [];
                  for (var value in rewards.snapshot.value.values) {
                    store.add(new Store.fromJson(value));
                  }
                  return Container(
                    padding: EdgeInsets.only(top: screenUtil.setHeight(32)),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: store.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RewardsCard(
                              imageUrl: store.elementAt(index).storeBanner,
                              name: store.elementAt(index).storeName,
                              desc: store.elementAt(index).storeDesc,
                            );
                          },
                        )
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

FutureBuilder(
              future: reference.once(),
              builder:
                  (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.value);
                  List<StoreModel> stores = [];
                  Map<dynamic, dynamic> rewards = snapshot.data!.value;
                  for (var store in rewards.values) {
                    StoreModel model = new StoreModel(store.value["storeName"],
                        store.value["storeDesc"], store.value["storeBanner"]);
                    stores.add(model);
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: stores.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RewardsCard(
                            imageUrl: stores.elementAt(index).storeBanner,
                            name: stores.elementAt(index).storeName,
                            desc: stores.elementAt(index).storeDesc,
                          );
                        },
                      )
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

 */

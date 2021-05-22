import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/ui/tab_screens/home_tab.dart';
import 'package:wear_helmet/ui/tab_screens/profile_tab.dart';
import 'package:wear_helmet/ui/tab_screens/rewards_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenUtil screenUtil = new ScreenUtil();
  int _selectedIndex = 0;
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('users');

  Future<String> getData() async => reference
          .child(currentUser)
          .child('profile')
          .once()
          .then((DataSnapshot snapshot) {
        return snapshot.value;
      });

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    RewardsTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              appBar: AppBar(
                backgroundColor: ThemeColors.white,
                shadowColor: Colors.transparent,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: screenUtil.setWidth(24),
                        top: screenUtil.setHeight(24),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: FutureBuilder(
                          future: getData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data);
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: _widgetOptions.elementAt(_selectedIndex),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.card_giftcard,
                    ),
                    label: 'Rewards',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                    label: 'Profile',
                  ),
                ],
                iconSize: ScreenUtil().setWidth(30),
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                currentIndex: _selectedIndex,
                selectedIconTheme: IconThemeData(size: ScreenUtil().setWidth(30)),
                selectedItemColor: ThemeColors.primaryColorLight,
                unselectedItemColor: Colors.blueGrey[800],
                onTap: _onItemTapped,
              ),
            ),
    );
  }
}

/*
onPressed: () {
                    context
                        .read<AuthenticationService>()
                        .signOut()
                        .whenComplete(
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoardingScreen(),
                            ),
                          ),
                        );
                  },
 */

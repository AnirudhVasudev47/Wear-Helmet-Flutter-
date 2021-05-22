import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wear_helmet/global/theme.dart';
import 'package:wear_helmet/services/authentication.dart';
import 'package:wear_helmet/ui/screen/home_page.dart';
import 'package:wear_helmet/ui/screen/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 830),
      builder: () {
        return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: currentTheme.currentTheme,
            home: AuthenticationWrapper(),
          ),
        );
      });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    if (firebaseAuth.currentUser == null) {
      return OnBoardingScreen();
    }else {
      return HomePage();
    }

  }
}

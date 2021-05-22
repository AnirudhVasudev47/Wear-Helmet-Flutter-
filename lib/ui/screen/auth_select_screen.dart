import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/ui/screen/login_screen.dart';
import 'package:wear_helmet/ui/screen/sign_up_screen.dart';

class AuthSelectScreen extends StatefulWidget {
  const AuthSelectScreen({Key? key}) : super(key: key);

  @override
  _AuthSelectScreenState createState() => _AuthSelectScreenState();
}

class _AuthSelectScreenState extends State<AuthSelectScreen> {
  ScreenUtil screenUtil = new ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: screenUtil.setHeight(100),
                      child: Container(
                        child: Image.asset(
                            'assets/images/auth_screen/background_circle_1.png'),
                      ),
                    ),
                    Positioned(
                      top: screenUtil.setHeight(100),
                      left: screenUtil.setWidth(25),
                      child: Container(
                        child:
                            Image.asset('assets/images/auth_screen/auth.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: screenUtil.setWidth(32)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColors.prime)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenUtil.setWidth(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenUtil.setHeight(25),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: screenUtil.setWidth(32)),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ThemeColors.prime, width: 2),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenUtil.setWidth(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.prime),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ThemeColors.prime,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenUtil.setHeight(117),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

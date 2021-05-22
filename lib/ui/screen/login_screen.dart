import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/services/authentication.dart';
import 'package:wear_helmet/ui/screen/home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  ScreenUtil screenUtil = new ScreenUtil();
  TextEditingController emailText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  Color iconColor = Colors.grey;
  bool _obscureText = true;
  String? emailError;
  String? passError;
  Future<String>? signInResult;

  bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void checkFields() {
    print(emailText.text);
    if (emailText.text.isEmpty) {
      setState(() {
        emailError = 'Email empty';
      });
    } else if (passwordText.text.isEmpty) {
      setState(() {
        passError = 'Password empty';
      });
    } else if (!isEmail(emailText.text)) {
      setState(() {
        emailError = 'Email not correct';
      });
    } else {
      setState(() {
        emailError = null;
        passError = null;
      });
    }
  }

  emailTextChanged(text) {
    if (isEmail(text)) {
      setState(() {
        iconColor = ThemeColors.prime;
      });
    } else {
      setState(() {
        iconColor = Colors.grey;
      });
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: screenUtil.setHeight(43),
                left: 0,
                child: Container(
                  child: Image.asset(
                    'assets/images/auth_screen/background_circle_2.png',
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: screenUtil.setHeight(32),
                          top: screenUtil.setHeight(169),
                        ),
                        child: Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: screenUtil.setWidth(32)),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(32),
                    ),

                    //Email Address

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: TextFormField(
                        controller: emailText,
                        cursorColor: ThemeColors.prime,
                        maxLength: 50,
                        onChanged: emailTextChanged,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          errorText: emailError,
                          hintText: 'Eg: abc@example.com',
                          labelStyle: TextStyle(
                            color: ThemeColors.prime,
                          ),
                          suffixIcon: Icon(
                            Icons.check,
                            color: iconColor,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.prime),
                          ),
                        ),
                      ),
                    ),

                    //Password

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: TextFormField(
                        controller: passwordText,
                        cursorColor: ThemeColors.prime,
                        maxLength: 50,
                        onChanged: emailTextChanged,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: passError,
                          hintText: 'Your password',
                          labelStyle: TextStyle(
                            color: ThemeColors.prime,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: _obscureText
                                ? Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.remove_red_eye,
                                    color: ThemeColors.prime,
                                  ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.prime),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(16),
                    ),

                    //Sign In button

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ThemeColors.prime)),
                        onPressed: emailLogin,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenUtil.setWidth(25),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(16),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffD2D2D2),
                      height: 0,
                      indent: screenUtil.setWidth(16),
                      endIndent: screenUtil.setWidth(16),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(16),
                    ),

                    //Sign in google

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: ThemeColors.prime, width: 2),
                        ),
                        onPressed: googleSignIn,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenUtil.setWidth(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/images/auth_screen/google.png'),
                              SizedBox(
                                width: screenUtil.setWidth(10),
                              ),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeColors.prime),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  emailLogin() {
    checkFields();
    if (emailError == null && passError == null) {
      signInResult = context
          .read<AuthenticationService>()
          .signIn(
            email: emailText.text.trim(),
            password: passwordText.text.trim(),
          )
          .whenComplete(() {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    }
  }

  void googleSignIn() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            child: Lottie.asset('assets/lottie/bike_loader.json'),
          );
        });
    signInResult = context
        .read<AuthenticationService>()
        .signInWithGoogle()
        .whenComplete(() {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }) as Future<String>?;
  }
}

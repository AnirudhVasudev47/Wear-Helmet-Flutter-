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
import 'package:wear_helmet/ui/widget/loading_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ScreenUtil screenUtil = new ScreenUtil();
  TextEditingController emailText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  TextEditingController confirmPasswordText = new TextEditingController();
  Color iconColor = Colors.grey;
  bool _obscureText = true;
  String? emailError;
  String? passError;
  String? passConfirmError;
  Future<String>? signInResult;

  GlobalKey loading = new GlobalKey();

  bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
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
    } else if (passwordText.text != confirmPasswordText.text) {
      setState(() {
        passConfirmError = 'password does not match';
      });
    } else {
      setState(() {
        emailError = null;
        passError = null;
        passConfirmError = null;
      });
    }
  }

  onFailure(String string) {
    print(string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                          top: screenUtil.setHeight(110),
                        ),
                        child: Text(
                          'Registration',
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
                        'Register',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    //Email Address

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: TextFormField(
                        controller: emailText,
                        cursorColor: ThemeColors.prime,
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
                        onChanged: emailTextChanged,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Your password',
                          errorText: passError,
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

                    //Confirm Password

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.setWidth(32)),
                      child: TextFormField(
                        controller: confirmPasswordText,
                        cursorColor: ThemeColors.prime,
                        onChanged: emailTextChanged,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Reenter your password',
                          errorText: passConfirmError,
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

                    //Register

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
                                    'Register',
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

                    //Sign in with Google

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
                      height: screenUtil.setHeight(25),
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
    if (emailError == null && passConfirmError == null && passError == null) {
      signInResult = context
          .read<AuthenticationService>()
          .signUp(
            email: emailText.text.trim(),
            password: passwordText.text.trim(),
          )
          .whenComplete(() {
        DatabaseReference databaseRef =
            FirebaseDatabase.instance.reference().child("users");
        Map<String, dynamic> userInfo = new Map();
        RegExp exp = RegExp(r"([\w+._]*)");
        String str = emailText.text;
        Iterable<RegExpMatch> matches = exp.allMatches(str);
        userInfo['username'] = matches.elementAt(0).group(1);
        userInfo['firstName'] = '';
        userInfo['lastName'] = '';
        userInfo['dob'] = '';
        userInfo['points'] = 0;
        userInfo['kilometer'] = 0;
        databaseRef
            .child(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(userInfo);
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
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.reference().child("users");
      Map<String, dynamic> userInfo = new Map();
      userInfo['username'] = FirebaseAuth.instance.currentUser!.displayName;
      userInfo['firstName'] = '';
      userInfo['lastName'] = '';
      userInfo['dob'] = '';
      userInfo['points'] = 0;
      userInfo['kilometer'] = 0;
      userInfo['profile'] = 'https://img-premium.flaticon.com/png/512/860/860784.png?token=exp=1621271586~hmac=f9720192db639fe7273fe0eb841e08e7';
      databaseRef
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .set(userInfo);
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }) as Future<String>?;
  }
}

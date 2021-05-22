import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingClass extends StatefulWidget {
  final function;
  const LoadingClass({Key? key, this.function}) : super(key: key);

  @override
  _LoadingClassState createState() => _LoadingClassState();
}

class _LoadingClassState extends State<LoadingClass> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Lottie.asset('assets/lottie/bike_loader.json'),
    );
  }



}

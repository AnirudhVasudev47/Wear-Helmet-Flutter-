import 'package:flutter/material.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({Key? key}) : super(key: key);

  @override
  _RewardsTabState createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Rewards'),
      ),
    );
  }
}

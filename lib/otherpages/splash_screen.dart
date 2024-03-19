import 'dart:async';

import 'package:chill_bill/common/dashboard/dashboard.dart';
import 'package:chill_bill/otherpages/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool user;
  SplashScreen({required this.user});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (c) => widget.user ? WalletAppClone() : Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xffF3AB0D),
        backgroundColor: Color.fromRGBO(38, 81, 158, 1),
        body: Center(
          child: Text(
            "Chill Bill",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ));
  }
}

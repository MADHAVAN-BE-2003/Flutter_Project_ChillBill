import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/otherpages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool user = false;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('user') != null) {
      setState(() {
        // user = prefs.getBool('user');
        user = (prefs.getBool('user') ?? false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xffF5F6F8),
        fontFamily: "Nunito",
      ),
      title: 'Chill Bill',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(user),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

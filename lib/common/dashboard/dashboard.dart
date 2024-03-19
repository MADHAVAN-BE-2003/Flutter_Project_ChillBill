import 'package:chill_bill/common/drawer.dart';
import 'package:flutter/material.dart';
import 'screens/cards_page.dart';
import 'screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// void main() => runApp(const WalletAppClone());

class WalletAppClone extends StatefulWidget {
  const WalletAppClone({Key? key}) : super(key: key);
  // static const String path = 'lib/main.dart';
  @override
  State<WalletAppClone> createState() => _WalletAppCloneState();
}

class _WalletAppCloneState extends State<WalletAppClone> {
  // @override
  // void initState() {
  //   super.initState();

  // }
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('regularprint') == null) {
      prefs.setBool('regularprint', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WalletApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class WalletAppClone extends StatelessWidget {

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WalletApp(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class WalletApp extends StatefulWidget {
  @override
  _WalletAppState createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  var screens = [
    HomePage(),
    CardPage(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(icon: Icon(Icons.credit_card)),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       selectedTab = index;
      //     });
      //   },
      //   showUnselectedLabels: true,
      //   iconSize: 30,
      // ),
      appBar: AppBar(
        title: const Text('Chill Bill'),
        backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      ),
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[selectedTab],
    );
  }
}

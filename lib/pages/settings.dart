import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter_application_1/pages/invoice_setttings.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool productgrid = false;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? productgrid = prefs.getBool('productgrid');

    setState(() {
      if (prefs.getBool('productgrid') != null) {
        productgrid = productgrid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // user card
            // BigUserCard(
            //   cardColor: Color.fromARGB(255, 54, 82, 244),
            //   userName: "Babacar Ndong",
            //   userProfilePic: AssetImage("assets/images/profileimage.png"),
            //   cardActionWidget: SettingsItem(
            //     icons: Icons.edit,
            //     iconStyle: IconStyle(
            //       withBackground: true,
            //       borderRadius: 50,
            //       backgroundColor: Colors.yellow[600],
            //     ),
            //     title: "Modify",
            //     subtitle: "Tap to change your data",
            //     onTap: () {
            //       print("OK");
            //     },
            //   ),
            // ),
            // SimpleUserCard(
            //   userName: "Nom de l'utilisateur",
            //   userProfilePic: AssetImage("assets/images/profileimage.png"),
            // ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'General',
                  // subtitle: "Make Ziar'App yours",
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Invoicesettings()),
                    );
                  },
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Invoice Print',
                  // subtitle: "Lock Ziar'App to improve your privacy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.grid_4x4_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Product',
                  subtitle: "GRID View",
                  trailing: Switch.adaptive(
                    value: productgrid,
                    onChanged: (value) async {
                      setState(() {
                        productgrid = value;
                      });
                      final store = await SharedPreferences.getInstance();
                      store.setBool('productgrid', value);
                    },
                  ),
                ),
                // SettingsItem(
                //   onTap: () {},
                //   icons: Icons.dark_mode_rounded,
                //   iconStyle: IconStyle(
                //     iconsColor: Colors.white,
                //     withBackground: true,
                //     backgroundColor: Colors.red,
                //   ),
                //   title: 'Dark mode',
                //   subtitle: "Automatic",
                //   trailing: Switch.adaptive(
                //     value: false,
                //     onChanged: (value) {},
                //   ),
                // ),
              ],
            ),
            // SettingsGroup(
            //   items: [
            //     SettingsItem(
            //       onTap: () {},
            //       icons: Icons.info_rounded,
            //       iconStyle: IconStyle(
            //         backgroundColor: Colors.purple,
            //       ),
            //       title: 'About',
            //       subtitle: "Learn more about Ziar'App",
            //     ),
            //   ],
            // ),
            // // You can add a settings title
            // SettingsGroup(
            //   settingsGroupTitle: "Account",
            //   items: [
            //     SettingsItem(
            //       onTap: () {},
            //       icons: Icons.exit_to_app_rounded,
            //       title: "Sign Out",
            //     ),
            //     SettingsItem(
            //       onTap: () {},
            //       icons: CupertinoIcons.repeat,
            //       title: "Change email",
            //     ),
            //     SettingsItem(
            //       onTap: () {},
            //       icons: CupertinoIcons.delete_solid,
            //       title: "Delete account",
            //       titleStyle: TextStyle(
            //         color: Colors.red,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

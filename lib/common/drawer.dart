import 'package:chill_bill/otherpages/login.dart';
import 'package:chill_bill/pages/category/category.dart';
import 'package:chill_bill/pages/company/company.dart';
import 'package:chill_bill/pages/items/items.dart';
import 'package:chill_bill/pages/master/master.dart';
import 'package:chill_bill/pages/product_category/category.dart';
import 'package:chill_bill/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chill_bill/pages/customers/customers.dart';
import 'package:chill_bill/pages/sales/sales.dart';
import 'package:chill_bill/pages/vendor/vendors.dart';
// import 'package:flutter_application_1/createpdf/main_pdf.dart';
import 'package:chill_bill/pages/settings.dart';
import 'package:chill_bill/pages/expenses/expenses.dart';
// import 'package:flutter_application_1/pages/category/category.dart';
import 'package:chill_bill/pages/purchase/sales.dart';
// C:\flutterprojects\invoice_build\flutter_application_1\lib\pages\product_category\categorycreate.dart

// C:\flutterprojects\invoice\lib\pages\settings.dart
// import 'package:flutter_application_1/login_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

String loginusername = '';
String loginfirstname = '';
String loginlastname = '';
String loginemail = '';
String loginrole = '';

class _SideMenuState extends State<SideMenu> {
  // bool loginstatus = false;

  // void _onBackButtonPressed() {
  //   print('asdasdasd karthik');
  // }

  void initState() {
    super.initState();

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // setState(() {
    //   // user = prefs.getBool('user');
    //   loginusername = prefs.getString('username').toString();
    //   loginfirstname = prefs.getString('firstname').toString();
    //   loginlastname = prefs.getString('lastname').toString();
    //   loginemail = prefs.getString('lastname').toString();
    // });

    loginusergetstate();
  }

  loginusergetstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // user = prefs.getBool('user');
      loginusername = prefs.getString('username').toString();
      loginfirstname = prefs.getString('firstname').toString();
      loginlastname = prefs.getString('lastname').toString();
      loginemail = prefs.getString('email').toString();
      loginrole = prefs.getString('role').toString();
    });
  }

  // checklogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   loginstatus = (prefs.getBool('loginstatus') ?? false);

  //   print('drawpage false');
  //   print(loginstatus);
  //   if (loginstatus == false) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );
  //   }
  //   // var duration = const Duration(seconds: 3);
  //   // return Timer(duration, () {
  //   //   Navigator.of(context).pushReplacement(
  //   //     MaterialPageRoute(builder: (c) => widget.user ? Dashboard() : Login()),
  //   //   );
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/user_background.jpg"),
                    fit: BoxFit.cover)),
            accountName: Text("$loginusername"),
            accountEmail: Text("$loginemail"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.red,
              backgroundImage: AssetImage("assets/images/profileimage.png"),
            ),
          ),
          // DrawerHeader(
          //   child: Image.asset("assets/images/profileimage.png", width: 20.0),

          // ),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              size: 30,
            ),
            title: Text('Dashboard'),
            // subtitle: Text("This is the 1st item"),
            // trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          if (loginrole != "4") ...[
            ExpansionTile(
              title: Text("Logins"),
              leading: Icon(
                Icons.perm_identity,
                size: 30,
              ),
              children: [
                if (loginrole == "1") ...[
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                    leading: Icon(
                      Icons.assignment_ind,
                      size: 30,
                    ),
                    title: Text('Master Login'),
                    // subtitle: Text("This is the 1st item"),
                    // trailing: Icon(Icons.more_vert),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Master()),
                      );
                    },
                  ),
                ],
                if (loginrole == "2" || loginrole == "1") ...[
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                    leading: Icon(
                      Icons.business,
                      size: 30,
                    ),
                    title: Text('Company Login'),
                    // subtitle: Text("This is the 1st item"),
                    // trailing: Icon(Icons.more_vert),
                    onTap: () {
                      print("company");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Company()),
                      );
                    },
                  ),
                ],
                ListTile(
                  contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                  leading: Icon(
                    Icons.work,
                    size: 30,
                  ),
                  title: Text('Employer Login'),
                  // subtitle: Text("This is the 1st item"),
                  // trailing: Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Users()),
                    );
                  },
                )
              ],
            ),
          ],
          ExpansionTile(
            title: Text("Master"),
            leading: Icon(
              Icons.account_tree_outlined,
              size: 30,
            ),
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.format_list_bulleted,
                  size: 30,
                ),
                title: Text('Products'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Items()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.not_listed_location,
                  size: 30,
                ),
                title: Text('Product Category'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductCategory()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.assistant,
                  size: 30,
                ),
                title: Text('Customers'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Customers()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.add_business_outlined,
                  size: 30,
                ),
                title: Text('Vendor'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Vendors()),
                  );
                },
              )
            ],
          ),
          ExpansionTile(
            title: Text("Expenses"),
            leading: Icon(
              Icons.exposure,
              size: 30,
            ),
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.category,
                  size: 30,
                ),
                title: Text('Category'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 70.0, right: 0.0),
                leading: Icon(
                  Icons.attach_money,
                  size: 30,
                ),
                title: Text('Expenses'),
                // subtitle: Text("This is the 1st item"),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Expenses()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.point_of_sale,
              size: 30,
            ),
            title: Text('Sales'),
            // subtitle: Text("This is the 1st item"),
            // trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sales()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_shopping_cart,
              size: 30,
            ),
            title: Text('Purchase'),
            // subtitle: Text("This is the 1st item"),
            // trailing: Icon(Icons.more_vert),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Purchase()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text('Settings'),
            // subtitle: Text("This is the 1st item"),
            // trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 40,
            ),
            title: Text('Logout'),
            // subtitle: Text("This is the 1st item"),
            // trailing: Icon(Icons.more_vert),
            onTap: () async {
              final store = await SharedPreferences.getInstance();
              store.clear();
              // store.setBool('loginstatus', false);
              //    store.setString('test', _username.text);
              // store.setBool('loginstatus', true);
              // store.setBool('user', true);

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => Login()));
            },
          )
        ],
      ),
    );
  }
}

// class SideMenu extends StatelessWidget {
//   const SideMenu({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             child: Image.asset("assets/images/lock.png"),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.dashboard,
//               size: 40,
//             ),
//             title: Text('Dashboard'),
//             // subtitle: Text("This is the 1st item"),
//             // trailing: Icon(Icons.more_vert),
//             onTap: () {},
//           ),
//           ExpansionTile(
//             title: Text("Logins"),
//             leading: Icon(
//               Icons.login_sharp,
//               size: 40,
//             ),
//             children: [
//               ListTile(
//                 leading: Icon(
//                   Icons.masks_outlined,
//                   size: 40,
//                 ),
//                 title: Text('Master Login'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.co_present,
//                   size: 40,
//                 ),
//                 title: Text('Company Login'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.verified_user,
//                   size: 40,
//                 ),
//                 title: Text('User Login'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               )
//             ],
//           ),
//           ExpansionTile(
//             title: Text("Master"),
//             leading: Icon(
//               Icons.masks_outlined,
//               size: 40,
//             ),
//             children: [
//               ListTile(
//                 leading: Icon(
//                   Icons.masks_outlined,
//                   size: 40,
//                 ),
//                 title: Text('Items'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.co_present,
//                   size: 40,
//                 ),
//                 title: Text('Costomers'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.verified_user,
//                   size: 40,
//                 ),
//                 title: Text('Vendors'),
//                 // subtitle: Text("This is the 1st item"),
//                 // trailing: Icon(Icons.more_vert),
//                 onTap: () {},
//               )
//             ],
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.logout,
//               size: 40,
//             ),
//             title: Text('Logout'),
//             // subtitle: Text("This is the 1st item"),
//             // trailing: Icon(Icons.more_vert),
//             onTap: () async {
//               final store = await SharedPreferences.getInstance();
//               store.setBool('loginstatus', false);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Color.fromARGB(137, 10, 10, 10),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color.fromARGB(137, 12, 12, 12)),
      ),
    );
  }
}

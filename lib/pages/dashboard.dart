import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/common/apicall.dart';
import 'package:flutter_application_1/common/apimodal.dart';
import 'package:flutter_application_1/common/drawer.dart';

import 'package:flutter_application_1/design_course/category_list_view.dart';
import 'package:flutter_application_1/design_course/course_info_screen.dart';
import 'package:flutter_application_1/design_course/popular_course_list_view.dart';
import 'package:flutter_application_1/main.dart';
// import 'design_course_app_theme.dart';
import 'package:flutter_application_1/design_course/design_course_app_theme.dart';
// import 'package:flutter_application_1/common/MenuController.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

class _DashBoardState extends State<DashBoard> {
  String btnname = "";
  @override
  void initState() {
    super.initState();
    getCredential();
    futureAlbum = fetchAlbum();
  }

  getCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      btnname = (prefs.getString('test') ?? '');
    });
  }

  late Future<Album> futureAlbum;
  CategoryType categoryType = CategoryType.ui;
  @override
  Widget build(BuildContext context) {
    // String btnname = '';
    // setState(() {
    //   btnname = '';
    //   getCredential();
    // });
    // final store = await SharedPreferences.getInstance();
    return MaterialApp(
      title: 'Chill Bill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chill Bill'),
        ),
        drawer: SideMenu(),
        body: Column(
          children: <Widget>[
            // SizedBox(
            //   height: MediaQuery.of(context).padding.top,
            // ),
            // getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      // getSearchBarUI(),
                      getCategoryUI(),
                      Flexible(
                        child: getPopularCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //   body: Container(
        //     margin: EdgeInsets.only(top: 16.0),
        //     padding: EdgeInsets.all(16.0),
        //     child: Row(
        //       children: [
        //         Container(
        //           // margin: EdgeInsets.only(top: 16.0),
        //           padding: EdgeInsets.all(16.0),
        //           height: 200,
        //           width: 200,
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //                 width: 2, color: primaryColor.withOpacity(0.15)),
        //             borderRadius: const BorderRadius.all(
        //               Radius.circular(16.0),
        //             ),
        //             // border: Border.all(
        //             //   width: 3,
        //             color: Color.fromARGB(255, 17, 19, 17),
        //             //   style: BorderStyle.solid,
        //             // ),
        //           ),
        //           child: Center(
        //             child: Text(
        //               "Helaaalo",
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 30,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 100,
        //           width: 100,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.only(
        //               topRight: Radius.circular(40),
        //             ),
        //             border: Border.all(
        //               width: 3,
        //               color: Colors.green,
        //               style: BorderStyle.solid,
        //             ),
        //           ),
        //           child: Center(
        //             child: Text(
        //               "Helaaalo",
        //             ),
        //           ),
        //         ),
        //       ],

        //       // body: Center(
        //       //   child: FlatButton(
        //       //     color: Colors.red,
        //       //     onPressed: () {
        //       //       Navigator.of(context).pop();
        //       //     },
        //       //     child: Text('$btnname'),
        //       //   ),
        //       //   // child: FutureBuilder<Album>(
        //       //   //   future: futureAlbum,
        //       //   //   builder: (context, snapshot) {
        //       //   //     if (snapshot.hasData) {
        //       //   //       return Text(snapshot.data.title);
        //       //   //     } else if (snapshot.hasError) {
        //       //   //       return Text('${snapshot.error}');
        //       //   //     }

        //       //   //     // By default, show a loading spinner.
        //       //   //     return const CircularProgressIndicator();
        //       //   //   },
        //       //   // ),
        //       // ),
        //     ),
        //   ),
      ),
    );
  }

  // getCredential() async {
  //   final store = await SharedPreferences.getInstance();
  //   // print(store.getString('test'));
  //   btnname = store.getString('test');
  // }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          // child: Text(
          //   'Category',
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 22,
          //     letterSpacing: 0.27,
          //     color: DesignCourseAppTheme.darkerText,
          //   ),
          // ),
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16, right: 16),
        //   child: Row(
        //     children: <Widget>[
        //       getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
        //       const SizedBox(
        //         width: 16,
        //       ),
        //       getButtonUI(
        //           CategoryType.coding, categoryType == CategoryType.coding),
        //       const SizedBox(
        //         width: 16,
        //       ),
        //       getButtonUI(
        //           CategoryType.basic, categoryType == CategoryType.basic),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Popular Course',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Colors.grey.shade400),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Choose your',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Design Course',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
// }
}

import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

// import './selectable_item.dart';
// import './selection_app_bar.dart';
import './griditem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

final storage = new LocalStorage('store_product');

class Productgridk extends StatefulWidget {
  const Productgridk({
    required this.startingTabCountapp,
    required this.category_listapp,
    required this.products_listapp,
    required this.clearall,
  });

  final int startingTabCountapp;
  final dynamic category_listapp;
  final dynamic products_listapp;
  final bool clearall;

  @override
  _ProductgridkState createState() => _ProductgridkState();
}

class _ProductgridkState extends State<Productgridk>
    with TickerProviderStateMixin {
  late List<dynamic> itemList;
  late List<dynamic> itemList1;
  // late List<dynamic> selectedList;
  // late  int _startingTabCount = 0;
  var selectedList = [];
  var selectedListid = [];
  var selectedListid_count = [];
  var saved_seletelist = [];
  var category_list = [];
  String loginuserid = '';
  String loginrole = '';
  String salesinvoicesearch = '';
  int _startingTabCount = 0;

  List<Tab> _tabs = <Tab>[];
  List<Widget> _generalWidgets = <Widget>[];
  late TabController _tabController;

  // bool  clearall = false;

  @override
  void initState() {
    _startingTabCount = widget.startingTabCountapp;

    // print(widget.category_listapp[0]['name']);
    // loadListed();
    loadList();
    // print(itemList1[0][0]);
    _tabs = getTabs(_startingTabCount);
    _tabController = getTabController();
    super.initState();
  }

  // loadListed() async {
  //   itemList1 = [
  //     [
  //       {'id': 1, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 2, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 3, "image": "assets/images/grocery-transparent.png"}
  //     ],
  //     [
  //       {'id': 4, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 5, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 6, "image": "assets/images/grocery-transparent.png"}
  //     ],
  //     [
  //       {'id': 7, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 8, "image": "assets/images/grocery-transparent.png"},
  //       {'id': 9, "image": "assets/images/grocery-transparent.png"}
  //     ]
  //   ];
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   loginrole = prefs.getString('role').toString();
  //   loginuserid = prefs.getString('user_id').toString();
  //   salesinvoicesearch = prefs.getString('salesinvoicesearch').toString();

  //   var master_id = '';
  //   var company_id = '';
  //   if (loginrole == '2') {
  //     master_id = loginrole;
  //   }
  //   if (loginrole == '3') {
  //     company_id = loginrole;
  //   }

  //   var queryParameters = {
  //     // "page": paginate.page.toString(),
  //     // "limit": paginate.limit.toString(),
  //     "report_action": "product_list_grid",
  //     // "size": paginate.limit.toString(),
  //     "sortBy": '',
  //     "sortDesc": 'false',
  //     "master_id": master_id.toString(),
  //     "search": salesinvoicesearch.toString(),
  //     "company_id": company_id.toString()
  //   };

  //   var response = await http.post(
  //     Uri.parse('http://invoice.kingzquest.com/api/api.php'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     },
  //     body: queryParameters,
  //   );
  //   var result_data = jsonDecode(response.body);

  //   print("|api");
  //   _startingTabCount = result_data['category_list_count'];
  //   // print(result_data['category_list_count']);
  //   // print(result_data['category_list']);
  //   category_list = result_data['category_list'];
  //   // _tabs = getTabs(_startingTabCount);
  //   // _tabController = getTabController();
  // }

  loadList() {
    itemList = [];
    // itemList1 = [];
    // itemList1[0] = [];
    // itemList1[1] = [];
    // itemList1[2] = [];
    // itemList1[3] = [];
    selectedList = [];
    selectedListid = [];
    selectedListid_count = [];
    saved_seletelist = [];
    //  var itemList1 = [1, 2,3];

    //  itemList1 = [
    //   {
    //     {'id':1,"image":"assets/images/grocery-transparent.png"},
    //     {Item("assets/images/grocery-transparent.png", 2)},
    //     {Item("assets/images/grocery-transparent.png", 3)}
    //   },
    //   {
    //     {Item("assets/images/imageLogin.png", 4)},
    //     {Item("assets/images/grocery-transparent.png", 5)},
    //     {Item("assets/images/grocery-transparent.png", 6)}
    //   },
    //   {
    //     {Item("assets/images/imageLogin.png", 7)},
    //     {Item("assets/images/grocery-transparent.png", 8)},
    //     {Item("assets/images/grocery-transparent.png", 9)}
    //   }
    // ];
    itemList1 = widget.products_listapp;
    // print(widget.products_listapp);
    // print(">>>>>>>>>>>>>>>>>>>>>");
    // itemList1 = [
    //   [
    //     {'id': 1, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 2, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 3, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 4, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 5, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 6, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 7, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 8, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 9, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 10, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 11, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 12, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 13, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 14, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 15, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 16, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 17, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 18, "image": "assets/images/grocery-transparent.png"}
    //   ],
    //   [
    //     {'id': 19, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 20, "image": "assets/images/grocery-transparent.png"},
    //     {'id': 21, "image": "assets/images/grocery-transparent.png"}
    //   ]
    // ];

    // print(itemList1);

    // for (int loop = 1; loop < 3; loop++) {
    //   itemList1.add(itemList1[loop]);
    //   itemList1[loop].add(Item("assets/images/imageLogin.png", 1));
    // }

    // itemList1[0].add(Item("assets/images/imageLogin.png", 1));
    // itemList1[0].add(Item("assets/images/imageLogin.png", 2));
    // itemList1[0].add(Item("assets/images/grocery-transparent.png", 3));
    // itemList1[1].add(Item("assets/images/grocery-transparent.png", 4));
    // itemList1[1].add(Item("assets/images/grocery-transparent.png", 5));
    // itemList1[1].add(Item("assets/images/grocery-transparent.png", 6));
    // itemList1[2].add(Item("assets/images/grocery-transparent.png", 7));
    // itemList1[2].add(Item("assets/images/grocery-transparent.png", 8));
    // itemList1[2].add(Item("assets/images/grocery-transparent.png", 9));
    // itemList1[3].add(Item("assets/images/grocery-transparent.png", 10));
    // itemList1[3].add(Item("assets/images/grocery-transparent.png", 11));
    // itemList1[3].add(Item("assets/images/imageLogin.png", 12));
    itemList.add(Item("assets/images/grocery-transparent.png", 13));
    itemList.add(Item("assets/images/grocery-transparent.png", 14));
    itemList.add(Item("assets/images/grocery-transparent.png", 15));
    itemList.add(Item("assets/images/grocery-transparent.png", 16));
    itemList.add(Item("assets/images/grocery-transparent.png", 17));
    itemList.add(Item("assets/images/grocery-transparent.png", 18));
    itemList.add(Item("assets/images/grocery-transparent.png", 19));
    itemList.add(Item("assets/images/grocery-transparent.png", 20));

    // var selcountaa = [
    //   {'product_id': 190, 'product_count': 12}
    // ];

    print(widget.clearall);
    if (widget.clearall == false) {
      if (selectedListid_count.length == 0) {
        // if (widget.clearall == true) {
        //   storage.setItem('store_selectedListid_count', []);
        // }
        if (storage.getItem("store_selectedListid_count") != null) {
          selectedListid_count = storage.getItem('store_selectedListid_count');
        }
      } else {
        // if (widget.clearall == false) {
        storage.setItem('store_selectedListid_count', selectedListid_count);
        // }
      }
      storage.setItem('store_selectedListid_count', selectedListid_count);

      if (selectedListid.length == 0) {
        if (storage.getItem("store_selectedListid") != null) {
          selectedListid = storage.getItem('store_selectedListid');
        }
      } else {
        // if (widget.clearall == false) {
        storage.setItem('store_selectedListid', selectedListid);
        // }
      }
    } else {
      storage.setItem('store_selectedListid_count', []);
    }
    // storage.setItem('store_selectedListid', selectedListid);

    // var producat = storage.getItem('store_selectedListid_count');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getAppBar(),
      appBar: AppBar(
        title: Text("Product"),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          isScrollable: true,
        ),
        //   // actions:
        //   // actions: <Widget>[
        //   //   IconButton(
        //   //     icon: Icon(Icons.add),
        //   //     onPressed: _addIfCanAnotherTab,
        //   //   ),
        //   //   IconButton(
        //   //     icon: Icon(Icons.remove),
        //   //     onPressed: _removeTab,
        //   //   ),
        //   // ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: getWidgets(),
            ),
          ),
          Row(
            children: <Widget>[
              if (!isFirstPage())
                Expanded(
                  child: TextButton(
                      child: Text("Back"), onPressed: goToPreviousPage),
                ),
              Expanded(
                child: TextButton(
                    child: Text(isLastPage() ? "Finish" : "Next"),
                    onPressed: goToNextPage),
              )
            ],
          )
        ],
      ),
    );
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this)
      ..addListener(_updatePage);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
        // text: "$widgetNumber" + "asdasdas",
        text: widget.category_listapp[widgetNumber]['name']);
  }

  Widget getWidget(int widgetNumber) {
    setState(() {
      // selectedList[widgetNumber + 1] = [];
    });
    // final controller = new DragSelectGridViewController();
    // // final controller."$widgetNumber" = new DragSelectGridViewController();

    // @override
    // void initState() {
    //   super.initState();
    //   // controller.addListener(scheduleRebuild);
    //   // controller1.addListener(scheduleRebuild);
    // }

    // @override
    // void dispose() {
    //   // controller.removeListener(scheduleRebuild);
    //   // controller1.removeListener(scheduleRebuild);
    //   super.dispose();
    // }

    // return DragSelectGridView(
    //   triggerSelectionOnTap: true,
    //   gridController: controller,
    //   padding: const EdgeInsets.all(8),
    //   itemCount: 10,
    //   itemBuilder: (context, index, selected) {
    //     return SelectableItem(
    //         index: index,
    //         color: Colors.red,
    //         selected: selected,
    //         selection: controller.value.amount,
    //         prt_quantity: 0);
    //   },
    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 200,
    //     crossAxisSpacing: 12,
    //     mainAxisSpacing: 12,
    //   ),
    // );
    return GridView.builder(
        itemCount: itemList1[widgetNumber].length,
        // scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.1,
          // crossAxisSpacing: 0.0,
          // mainAxisSpacing: 0.0
        ),
        itemBuilder: (context, index) {
          // print(">>>>");
          // print(itemList1[widgetNumber][index]);
          // print(">>>>");
          // print(widgetNumber);
          // print(">>>><<>aa<>>");
          // print(selectedList);
          return GridItem(
              item: itemList1[widgetNumber][index],
              selectedlisted: selectedList,
              widgetNumbercrt: 0,
              selectedListids: selectedListid,
              selectedListid_counts: selectedListid_count,
              isSelected: (bool value) {
                // var selcountaa = [
                //   {'product_id': 10, 'product_count': 12}
                // ];
                // storage.setItem('store_selectedListid_count', selcountaa);

                setState(() {
                  if (storage.getItem("store_product_list") != null) {
                    saved_seletelist = storage.getItem('store_product_list');
                  }
                  var crntCount = 1;

                  var product_id_crnt = itemList1[widgetNumber][index]['id'];
                  if (value) {
                    // print("inn");
                    selectedList.add(itemList1[widgetNumber][index]);
                    // selectedListid.add(itemList1[widgetNumber][index].id);
                    itemList1[widgetNumber][index].forEach((key, value) {
                      if (key == "id") {
                        // print(value);
                        selectedListid.add(value);
                        var selcount = {
                          'product_id': value,
                          'product_count': 1
                        };
                        selectedListid_count.add(selcount);
                      }
                      // print("Key : ${key} value ${value}");
                    });

                    var totalprice = crntCount *
                        int.parse(itemList1[widgetNumber][index]['sale_price']);
                    var arrayval = {
                      'headerValue':
                          itemList1[widgetNumber][index]['name'].toString(),
                      'headerprice': itemList1[widgetNumber][index]
                              ['sale_price']
                          .toString(),
                      'headercode':
                          itemList1[widgetNumber][index]['code'].toString(),
                      'headerquentity': crntCount.toString(),
                      'headertax':
                          itemList1[widgetNumber][index]['tax'].toString(),
                      'headerid':
                          itemList1[widgetNumber][index]['id'].toString(),
                      'headertotal': totalprice.toString(),
                      'grandtotal': '6',
                    };
                    saved_seletelist.add(arrayval);
                  } else {
                    // print("out");

                    // var add_status = false;
                    // var selcount = {
                    //   'product_id': itemList1[widgetNumber][index]['id'],
                    //   'product_count': 1
                    // };

                    // var selcount = {};
                    // print(itemList1[widgetNumber][index]['id']);
                    // selectedList.remove(itemList1[widgetNumber][index]);
                    var fordisable = true;
                    selectedListid_count.forEach((element) {
                      // print("count");

                      if (itemList1[widgetNumber][index]['id'] ==
                              element['product_id'] &&
                          fordisable) {
                        fordisable = false;
                        // add_status = true;
                        crntCount = element['product_count'] + 1;
                        // print(crntCount);
                        // print("product_count");
                        // print(element['product_count']);
                        // print("product_id");
                        // print(element['product_id']);
                        var selcount = {
                          'product_id': element['product_id'],
                          'product_count': crntCount
                        };
                        selectedListid_count.remove(element);
                        selectedListid_count.add(selcount);
                      }

                      // print(element['product_id']);
                    });

                    // if (add_status) {
                    //   selectedListid_count.add(selcount);
                    // }

                    itemList1[widgetNumber][index].forEach((key, value) {
                      if (key == "id") {
                        // selectedListid.remove(value);
                      }
                      // print("Key : ${key} value ${value}");
                    });
                  }
                  var elemted_added = true;
                  if (saved_seletelist.length == 0) {
                    var totalprice = crntCount *
                        int.parse(itemList1[widgetNumber][index]['sale_price']);
                    elemted_added = false;
                    var arrayval = {
                      'headerValue':
                          itemList1[widgetNumber][index]['name'].toString(),
                      'headerprice': itemList1[widgetNumber][index]
                              ['sale_price']
                          .toString(),
                      'headercode':
                          itemList1[widgetNumber][index]['code'].toString(),
                      'headerquentity': crntCount.toString(),
                      'headertax':
                          itemList1[widgetNumber][index]['tax'].toString(),
                      'headerid':
                          itemList1[widgetNumber][index]['id'].toString(),
                      'headertotal': totalprice.toString(),
                      'grandtotal': '6',
                    };

                    saved_seletelist.add(arrayval);
                  } else {
                    var fordisablea = true;
                    saved_seletelist.forEach((element) {
                      print("element");
                      // print(element["headerValue"]);
                      // saved_seletelist.remove(element);
                      // if (itemList1[widgetNumber][index]['id'] ==
                      //     element['headerid']) {
                      // saved_seletelist.remove(element);
                      // }

                      if (itemList1[widgetNumber][index]['id'].toString() ==
                              element['headerid'].toString() &&
                          fordisablea) {
                        var totalprice = crntCount *
                            int.parse(
                                itemList1[widgetNumber][index]['sale_price']);
                        elemted_added = false;
                        fordisablea = false;
                        // add_status = true;
                        // crntCount = element['product_count'] + 1;
                        // print(crntCount);
                        // print("product_count");
                        // print(element['product_count']);
                        // print("product_id");
                        // print(element['product_id']);
                        var arrayval = {
                          'headerValue':
                              itemList1[widgetNumber][index]['name'].toString(),
                          'headerprice': itemList1[widgetNumber][index]
                                  ['sale_price']
                              .toString(),
                          'headercode':
                              itemList1[widgetNumber][index]['code'].toString(),
                          'headerquentity': crntCount.toString(),
                          'headertax':
                              itemList1[widgetNumber][index]['tax'].toString(),
                          'headerid':
                              itemList1[widgetNumber][index]['id'].toString(),
                          'headertotal': totalprice.toString(),
                          'grandtotal': '6',
                        };
                        saved_seletelist.remove(element);
                        saved_seletelist.add(arrayval);
                      } else {
                        // var arrayvalc = {
                        //   'headerValue':
                        //       itemList1[widgetNumber][index]['name'].toString(),
                        //   'headerprice': itemList1[widgetNumber][index]
                        //           ['purchase_price']
                        //       .toString(),
                        //   'headercode':
                        //       itemList1[widgetNumber][index]['code'].toString(),
                        //   'headerquentity': crntCount.toString(),
                        //   'headertax':
                        //       itemList1[widgetNumber][index]['tax'].toString(),
                        //   'headerid':
                        //       itemList1[widgetNumber][index]['id'].toString(),
                        //   'headertotal': itemList1[widgetNumber][index]
                        //           ['purchase_price']
                        //       .toString(),
                        //   'grandtotal': '6',
                        // };
                        // saved_seletelist.add(arrayvalc);
                      }
                    });
                  }

                  if (elemted_added) {
                    var totalprice = crntCount *
                        int.parse(itemList1[widgetNumber][index]['sale_price']);
                    var arrayval = {
                      'headerValue':
                          itemList1[widgetNumber][index]['name'].toString(),
                      'headerprice': itemList1[widgetNumber][index]
                              ['sale_price']
                          .toString(),
                      'headercode':
                          itemList1[widgetNumber][index]['code'].toString(),
                      'headerquentity': '5',
                      'headertax':
                          itemList1[widgetNumber][index]['tax'].toString(),
                      'headerid':
                          itemList1[widgetNumber][index]['id'].toString(),
                      'headertotal': totalprice.toString(),
                      'grandtotal': '6',
                    };
                    saved_seletelist.add(arrayval);
                  }
                  storage.setItem('store_product_list', saved_seletelist);
                  var product = storage.getItem('store_product_list');

                  var producattg = storage.getItem('store_selectedListid');
                  var producat = storage.getItem('store_selectedListid_count');
                  print("store_selectedListid_count");
                  print(producat);
                  print("store_product_list");
                  print(product);
                  print("store_selectedListid");
                  print(producattg);
                });

                // user = prefs.getBool('user');
                // SalesLogin{{}}
                // _selectedItems = _selectedItems + 1;
                // itemslistarray.add(arrayval);
                // print("$index : $value");
              },
              isRemoved: (bool value) {
                // print("isRemoved");
                // print(value);
                // print(itemList1[widgetNumber][index]['id']);
                // var product_id_crnt = itemList1[widgetNumber][index]['id'];
                // print("product_id_crnt");
                // print(product_id_crnt);
                var producattg = [];
                var remove_index;
                var i = 0;
                producattg = storage.getItem('store_selectedListid_count');
                producattg.forEach((element) {
                  // print("tytyttttt");
                  // print(element['product_id']);
                  // print(itemList1[widgetNumber][index]['id']);
                  // print(element);
                  if (itemList1[widgetNumber][index]['id'] ==
                      element['product_id']) {
                    remove_index = i;
                  }
                  i++;
                });
                //  producattg.remove(remove_index);
                if (remove_index != '') {
                  producattg..removeAt(remove_index);
                }

                var producattglist = [];

                var remove_indexa;
                var a = 0;
                producattglist = storage.getItem('store_product_list');
                producattglist.forEach((element) {
                  // print("ssssssssssss");
                  // print(itemList1[widgetNumber][index]['id']);
                  // print(element['headerid']);
                  if (itemList1[widgetNumber][index]['id'] ==
                      element['headerid']) {
                    // producattglist.remove(element);
                    remove_indexa = a;
                  }
                  a++;
                });
                if (remove_indexa != '') {
                  producattglist..removeAt(remove_indexa);
                }
              },
              key: Key(itemList[index].rank.toString()));
        });
  }

  // getAppBar() {
  //   return AppBar(
  //     title: Text(selectedList.length < 1
  //         ? "Multi Selection"
  //         : "${selectedList.length} item selected"),
  //     actions: <Widget>[
  //       selectedList.length < 1
  //           ? Container()
  //           : InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   for (int i = 0; i < selectedList.length; i++) {
  //                     itemList.remove(selectedList[i]);
  //                   }
  //                   selectedList = [];
  //                 });
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Icon(Icons.delete),
  //               ))
  //     ],
  //     bottom: TabBar(
  //       tabs: _tabs,
  //       controller: _tabController,
  //       isScrollable: true,
  //     ),
  //   );
  // }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(getWidget(i));
    }
    return _generalWidgets;
  }

  void _addIfCanAnotherTab() {
    if (_startingTabCount == _tabController.length) {
      showWarningTabAddDialog();
    } else {
      _addAnotherTab();
    }
  }

  void _addAnotherTab() {
    _tabs = getTabs(_tabs.length + 1);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _removeTab() {
    _tabs = getTabs(_tabs.length - 1);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _updatePage() {
    setState(() {});
  }

  //Tab helpers

  bool isFirstPage() {
    return _tabController.index == 0;
  }

  bool isLastPage() {
    return _tabController.index == _tabController.length - 1;
  }

  void goToPreviousPage() {
    _tabController.animateTo(_tabController.index - 1);
  }

  void goToNextPage() {
    isLastPage()
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("End reached"),
                content: Text("Thank you for playing around!")))
        : _tabController.animateTo(_tabController.index + 1);
  }

  void showWarningTabAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Cannot add more tabs"),
              content: Text("Let's avoid crashing, shall we?"),
              actions: <Widget>[
                TextButton(
                    child: Text("Crash it!"),
                    onPressed: () {
                      _addAnotherTab();
                      Navigator.pop(context);
                    }),
                TextButton(
                    child: Text("Ok"), onPressed: () => Navigator.pop(context))
              ],
            ));
  }
}

class Item {
  String imageUrl;
  int rank;

  Item(this.imageUrl, this.rank);
}

import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_1/pages/sales/salesform.dart';
import 'package:flutter_application_1/pages/sales/saleslogin.dart';
import 'package:flutter_application_1/pages/sales/pos.dart';
import 'package:flutter_application_1/pages/sales/list/view/cards_view.dart';
// import 'package:flutter_application_1/createpdf/page/pdf_page.dart';

// import 'package:infinite_scroll/view/cards_view.dart';

// import 'package:flutter_application_1/pages/master/masterlist.dart';
// import 'package:flutter_application_1/pages/master/addmaster.dart';
import 'package:localstorage/localstorage.dart';

final storage = new LocalStorage('store_product');

class Saleslist extends StatefulWidget {
  const Saleslist({Key? key}) : super(key: key);

  // @override

  @override
  State<Saleslist> createState() => _SaleslistState();
}

class _SaleslistState extends State<Saleslist> {
  @override
  void initState() {
    //  await storage.clear();
    _clearStorage();
    // print("store_product_list");
    // storage.setItem('store_product_list', []);
    // storage.setItem('store_selectedListid_count', []);
  }

  _clearStorage() async {
    await storage.clear();

    // setState(() {
    //   list.items = storage.getItem('todos') ?? [];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          // bottom: const TabBar(
          //   tabs: [
          //     Tab(
          //       icon: Icon(Icons.storage),
          //       // text: 'List',
          //     ),
          // Tab(
          //   icon: Icon(Icons.add_box),
          //   // text: 'Infinite Process',
          // ),
          // Tab(
          //   icon: Icon(Icons.print),
          //   // text: 'Infinite Process',
          // ),
          // Tab(
          //   icon: Icon(Icons.storage),
          //   text: 'Data Transfer',
          // ),
          // ],
          // ),
          title: const Text('Sale'),
        ),
        body: CardsView(),
        // body: const TabBarView(
        //   children: [
        //     CardsView(),
        //     // SalesLogin(),
        //     // Pos(),
        //   ],
        // ),
      ),
    );
  }
}

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
// import 'package:localstorage/localstorage.dart';

// final storage = new LocalStorage('store_product');

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  // @override

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  void initState() {
    // print("store_product_list");
    // storage.setItem('store_product_list', []);
    // storage.setItem('store_selectedListid_count', []);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.storage),
                // text: 'List',
              ),
              Tab(
                icon: Icon(Icons.add_box),
                // text: 'Infinite Process',
              ),
              // Tab(
              //   icon: Icon(Icons.print),
              //   // text: 'Infinite Process',
              // ),
              // Tab(
              //   icon: Icon(Icons.storage),
              //   text: 'Data Transfer',
              // ),
            ],
          ),
          title: const Text('Sale'),
        ),
        body: const TabBarView(
          children: [
            CardsView(),
            SalesLogin(),
            // Pos(),
          ],
        ),
      ),
    );
  }
}

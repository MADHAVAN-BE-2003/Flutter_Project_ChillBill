import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_1/pages/sales/salesform.dart';
import 'package:flutter_application_1/pages/purchase/saleslogin.dart';
import 'package:flutter_application_1/pages/purchase/pos.dart';
import 'package:flutter_application_1/pages/purchase/list/view/cards_view.dart';
// import 'package:flutter_application_1/createpdf/page/pdf_page.dart';

// import 'package:infinite_scroll/view/cards_view.dart';

// import 'package:flutter_application_1/pages/master/masterlist.dart';
// import 'package:flutter_application_1/pages/master/addmaster.dart';

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
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
          title: const Text('Purchase'),
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

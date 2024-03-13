import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_1/pages/master/masterform.dart';
import 'package:flutter_application_1/pages/customers/customerscreate.dart';
import 'package:flutter_application_1/pages/customers/list/view/cards_view.dart';

// import 'package:infinite_scroll/view/cards_view.dart';

// import 'package:flutter_application_1/pages/master/masterlist.dart';
// import 'package:flutter_application_1/pages/master/addmaster.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
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
              //   icon: Icon(Icons.storage),
              //   text: 'Data Transfer',
              // ),
            ],
          ),
          title: const Text('Customers'),
        ),
        body: const TabBarView(
          children: [
            CardsView(),
            ItemCreate(),
          ],
        ),
      ),
    );
  }
}

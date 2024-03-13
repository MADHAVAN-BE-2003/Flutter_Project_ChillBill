import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_1/pages/master/masterform.dart';
import 'package:flutter_application_1/pages/items/itemcreate.dart';
import 'package:flutter_application_1/pages/items/list/view/cards_view.dart';

// import 'package:infinite_scroll/view/cards_view.dart';

// import 'package:flutter_application_1/pages/master/masterlist.dart';
// import 'package:flutter_application_1/pages/master/addmaster.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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
          title: const Text('Items'),
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

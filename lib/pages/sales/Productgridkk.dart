import 'package:flutter/material.dart';
import './griditem.dart';

class Productgridkk extends StatefulWidget {
  const Productgridkk({
    required this.startingTabCountapp,
    required this.category_listapp,
  });

  final int startingTabCountapp;
  final dynamic category_listapp;

  @override
  _ProductgridkkState createState() => _ProductgridkkState();
}

class _ProductgridkkState extends State<Productgridkk> {
  late List<Item> itemList;
  late List<Item> selectedList;

  @override
  void initState() {
    loadList();
    super.initState();
  }

  loadList() {
    itemList = [];
    selectedList = [];
    itemList.add(Item("assets/images/grocery-transparent.png", 1));
    itemList.add(Item("assets/images/grocery-transparent.png", 2));
    itemList.add(Item("assets/images/grocery-transparent.png", 3));
    itemList.add(Item("assets/images/grocery-transparent.png", 4));
    itemList.add(Item("assets/images/grocery-transparent.png", 5));
    itemList.add(Item("assets/images/grocery-transparent.png", 6));
    itemList.add(Item("assets/images/grocery-transparent.png", 7));
    itemList.add(Item("assets/images/grocery-transparent.png", 8));
    itemList.add(Item("assets/images/grocery-transparent.png", 9));
    itemList.add(Item("assets/images/grocery-transparent.png", 10));
    itemList.add(Item("assets/images/grocery-transparent.png", 11));
    itemList.add(Item("assets/images/grocery-transparent.png", 12));
    itemList.add(Item("assets/images/grocery-transparent.png", 13));
    itemList.add(Item("assets/images/grocery-transparent.png", 14));
    itemList.add(Item("assets/images/grocery-transparent.png", 15));
    itemList.add(Item("assets/images/grocery-transparent.png", 16));
    itemList.add(Item("assets/images/grocery-transparent.png", 17));
    itemList.add(Item("assets/images/grocery-transparent.png", 18));
    itemList.add(Item("assets/images/grocery-transparent.png", 19));
    itemList.add(Item("assets/images/grocery-transparent.png", 20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: GridView.builder(
          itemCount: itemList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return GridItem(
                item: itemList[index],
                selectedlisted: selectedList,
                widgetNumbercrt: 1,
                selectedListids: [],
                selectedListid_counts: [],
                isSelected: (bool value) {
                  setState(() {
                    if (value) {
                      selectedList.add(itemList[index]);
                    } else {
                      selectedList.remove(itemList[index]);
                    }
                  });
                  print("$index : $value");
                },
                isRemoved: (bool value) {},
                key: Key(itemList[index].rank.toString()));
          }),
    );
  }

  getAppBar() {
    return AppBar(
      title: Text(selectedList.length < 1
          ? "Multi Selection"
          : "${selectedList.length} item selected"),
      actions: <Widget>[
        selectedList.length < 1
            ? Container()
            : InkWell(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < selectedList.length; i++) {
                      itemList.remove(selectedList[i]);
                    }
                    selectedList = [];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ))
      ],
    );
  }
}

class Item {
  String imageUrl;
  int rank;

  Item(this.imageUrl, this.rank);
}

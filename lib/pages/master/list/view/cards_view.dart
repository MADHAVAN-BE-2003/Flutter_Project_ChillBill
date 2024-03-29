import 'package:chill_bill/pages/master/list/view_model/cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'card_item_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class CardsView extends StatefulWidget {
//   const CardsView({ Key? key }) : super(key: key);

//   @override
//   State<CardsView> createState() => _CardsViewState();
// }

// class _CardsViewState extends State<CardsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

final _searchController = TextEditingController();

class CardsView extends StatefulWidget {
  // final CardsView card;
  // CardsView(this.card);
  const CardsView({Key? key}) : super(key: key);
  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  late CardsViewModel _vm;

  @override
  void initState() {
    _vm = CardsViewModel();
    _vm.init();
    _vm.fetchCards();

    super.initState();
    // initaction();
  }

  initaction() async {
    _searchController.text = '';
    final store = await SharedPreferences.getInstance();
    store.setString('mastersearch', _searchController.text);
  }

  Widget build(BuildContext context) {
    // final _searchController = TextEditingController();
    // _searchController.text = '';
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Cards'),
      // ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.search),
                    onPressed: () async {
                      final store = await SharedPreferences.getInstance();
                      store.setString('mastersearch', _searchController.text);
                      setState(() {
                        _vm.cards.length = 0;
                        _vm = CardsViewModel();
                        _vm.init();
                        _vm.fetchCards();
                      });
                      // _vm.cards = 1;
                      // controller.clear();
                      // onSearchTextChanged('');
                    },
                  ),
                  title: new TextField(
                    controller: _searchController,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    // onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () async {
                      // print("clear");
                      // _searchController.text = '';
                      _searchController.text = '';
                      final store = await SharedPreferences.getInstance();
                      store.setString('mastersearch', '');
                      setState(() {
                        _vm.cards.length = 0;
                        _vm = CardsViewModel();
                        _vm.init();
                        _vm.fetchCards();
                      });

                      // controller.clear();
                      // onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: Observer(builder: (_) {
              if (_vm.cards.isEmpty) {
                return _buildLoading;
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _vm.cards.length + 1,
                itemBuilder: (context, index) {
                  print(_vm.cards.length);
                  print(index);
                  if (index == _vm.cards.length) {
                    _vm.fetchCards();
                    return _buildLoading;
                    // return Container();
                  }

                  return CardItemView(card: _vm.cards[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

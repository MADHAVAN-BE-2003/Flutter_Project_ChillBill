import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_application_1/pages/sales/reports/viewmodel/cards_view_model.dart';

import 'card_item_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
  String totalamount = '0';
  String totalinvoice = '0';
  String totalpending = '0';
  String totalreceived = '0';
  late CardsViewModel _vm;

  TextEditingController fromdate = TextEditingController();
  TextEditingController todate = TextEditingController();
  TextEditingController search = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("All"), value: "All"),
      const DropdownMenuItem(child: Text("Paid"), value: "Paid"),
      const DropdownMenuItem(child: Text("Pending"), value: "Pending"),
    ];
    return menuItems;
  }

  String selectedValue = 'All';
  @override
  void initState() {
    _vm = CardsViewModel();
    _vm.init();
    _vm.fetchCards();
    super.initState();
    initaction();
  }

  initaction() async {
    _searchController.text = '';
    final store = await SharedPreferences.getInstance();
    store.setString('salesinvoicesearch', _searchController.text);
    store.setString('search', search.text);
    store.setString('fromdate', fromdate.text);
    store.setString('todate', todate.text);
    store.setString('statusitemssel', selectedValue);

    Future.delayed(Duration(seconds: 5), () {
      // Do something
      totals();
      // print("sdfsdfsdf");
    });
  }

  totals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    totalamount = prefs.getString('totalamount').toString();
    totalinvoice = prefs.getString('totalinvoice').toString();
    totalpending = prefs.getString('totalpending').toString();
    totalreceived = prefs.getString('totalreceived').toString();

    setState(() {
      totalamount = totalamount;
      totalinvoice = totalinvoice;
      totalpending = totalpending;
      totalreceived = totalreceived;
    });
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      backgroundColor: Colors.deepPurple,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.0)));

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Cards'),
      // ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                        controller: fromdate,
                        decoration: InputDecoration(
                            // icon: Icon(Icons.calendar_today), //i
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'From Date',
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "From Date",
                            fillColor: Colors.white70),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              fromdate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                            final store = await SharedPreferences.getInstance();
                            store.setString('fromdate', formattedDate);
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                  Flexible(
                    child: TextField(
                        readOnly: true,
                        controller: todate,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            // prefixText: _currency,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "To Date",
                            labelText: 'To Date',
                            fillColor: Colors.white70),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              todate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                            final store = await SharedPreferences.getInstance();
                            store.setString('todate', formattedDate);
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                          // icon: Icon(Icons.calendar_today), //i
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Search',
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Search",
                          fillColor: Colors.white70),
                      onChanged: (String? newValue) {
                        setState(() {
                          // search.text = newValue!;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: DropdownButtonFormField(
                      value: selectedValue,
                      items: dropdownItems,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        labelText: 'Status',
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      'Total Invoice',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      ' Total Amount',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Total Received',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Total Pending',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(totalinvoice),
                  ),
                  Flexible(
                    child: Text(totalamount),
                  ),
                  Flexible(
                    child: Text(totalreceived),
                  ),
                  Flexible(
                    child: Text(totalpending),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        _searchController.text = '';
                        final store = await SharedPreferences.getInstance();
                        store.setString('salesinvoicesearch', '');
                        store.setString('search', '');
                        store.setString('fromdate', '');
                        store.setString('todate', '');
                        store.setString('statusitemssel', 'All');

                        setState(() {
                          selectedValue = 'All';
                          search.text = '';
                          fromdate.text = '';
                          todate.text = '';
                        });

                        _vm.cards.length = 0;
                        _vm = CardsViewModel();
                        _vm.init();
                        _vm.fetchCards();
                        (context as Element).reassemble();
                        Future.delayed(Duration(seconds: 5), () {
                          // Do something
                          totals();
                          // print("sdfsdfsdf");
                        });
                      },
                      child: Text('Clear'),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        final store = await SharedPreferences.getInstance();
                        store.setString(
                            'salesinvoicesearch', _searchController.text);
                        store.setString('search', search.text);
                        store.setString('statusitemssel', selectedValue);
                        _vm.cards.length = 0;
                        _vm = CardsViewModel();
                        _vm.init();
                        _vm.fetchCards();
                        (context as Element).reassemble();
                        Future.delayed(Duration(seconds: 5), () {
                          // Do something
                          totals();
                          // print("aaaaaaaa");
                        });
                      },
                      child: Text('Search'),
                    ),
                  ),
                ],
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
                  // print(index);
                  // print(_vm.cards.length);
                  if (index == _vm.cards.length) {
                    _vm.fetchCards();
                    return _buildLoading;
                  }

                  return CardItemView(card: _vm.cards[index]);
                },
              );
            }),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: ' Total Invoice',
      //       backgroundColor: Color.fromARGB(255, 151, 151, 153),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Total Amount',
      //       backgroundColor: Color.fromARGB(255, 151, 151, 153),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'Total Received',
      //       backgroundColor: Color.fromARGB(255, 151, 151, 153),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Total Pending',
      //       backgroundColor: Color.fromARGB(255, 151, 151, 153),
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {},
      //   icon: const Icon(Icons.print),
      //   label: const Text('Save & print'),
      // ),
    );
  }

  Center get _buildLoading {
    return Center(
        // child: CircularProgressIndicator(),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
// import 'package:dio/dio.dart';
import 'dart:convert';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_application_1/common/autocomplete/flutter_typeahead.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/purchase/Sales.dart';

class Additems extends StatefulWidget {
  const Additems({Key? key}) : super(key: key);

  @override
  State<Additems> createState() => _AdditemsState();
}

class _AdditemsState extends State<Additems> {
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selecteditems;
  String? _selecteditemslist;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: FastFormSection(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            children: [
              FastForm(
                formKey: _formKey,
                onChanged: (value) {
                  formvalues = [];
                  formvalues.add(value);
                  // print(formvalues);
                },
                // child: Column(
                children: <Widget>[
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Seletct Items'),
                      controller: this._typeAheadController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await BackendServiceapi.getSuggestions(pattern);
                    },
                    itemBuilder: (context, Map<String, String> suggestion) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(suggestion['name']!),
                        // subtitle: Text('\$${suggestion['price']}'),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Map<String, String> suggestion) {
                      print(suggestion['name']);

                      setState(() {
                        _selecteditemslist = suggestion['name'];
                      });
                      // var concatenate = StringBuffer();
                      // concatenate.write(suggestion);
                      String selectedname = suggestion['name'].toString();
                      //  List<String> selectedname = suggestion['name'];
                      this._typeAheadController.text = selectedname;
                      // Navigator.of(context).push<void>(MaterialPageRoute(
                      //     builder: (context) => ProductPage(product: suggestion))
                      //     );
                    },
                    // onSuggestionSelected: (String suggestion) {
                    //   this._typeAheadController.text = suggestion;
                    // },
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a Customer' : null,
                    onSaved: (value) => this._selecteditems = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final store = await SharedPreferences.getInstance();
                      // print(_selecteditemslist);
                      if (_selecteditemslist != null) {
                        store.setString('itemname', "_selecteditems");
                        store.setBool('itemnamea', true);
                        store.setBool('itemnameb', true);
                        // Navigator.of(context).pop();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackendServiceapi {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        'name': query,
        'report_action': 'customerlisttest',
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];

    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;

    var albums = jsonDecode(data);

    // var limit = albums['totalcount'];
    // print(albums);
    // var users = albums['user_list'];
    print(albums.length);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString(),
          'price': Random().nextInt(100).toString()
        };
      });
    } else {
      return List.generate(1, (index) {
        return {
          'name': 'Empty'.toString(),
          'price': Random().nextInt(100).toString()
        };
      });
    }

    // return temperature;
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return usertdata.fromJson(jsonDecode(response.body));
    // throw Exception('Failed to load login');
    // } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    //   throw Exception('Failed to load login');
    // }
    // debugPrint(jsonDecode(response.body));
    // return List<dynamic>.jsonDecode(response.body);
    // return usertdata.fromJson(jsonDecode(response.body));
    // return jsonEncode(response.body);
    // debugPrint(vale);
    // // await Future<void>.delayed(Duration(seconds: 1));

    // return List.generate(5, (index) {
    //   return {
    //     'name': query + index.toString(),
    //     'price': Random().nextInt(100).toString()
    //   };
    // });
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset.zero, size.bottomRight(Offset.zero), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bad, but okay for example
    return true;
  }
}

// ignore_for_file: unused_import, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';
import 'package:chill_bill/common/api_call.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:chill_bill/common/auto_complete/flutter_typeahead.dart';
import 'package:chill_bill/pages/expenses/expenses.dart';

var category_id = '';

class ItemCreate extends StatefulWidget {
  const ItemCreate({Key? key}) : super(key: key);

  @override
  State<ItemCreate> createState() => _ItemCreateState();
}

class _ItemCreateState extends State<ItemCreate> {
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];

  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;

  var name = '';
  var phone = '';
  var address = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: SingleChildScrollView(
        child: FastFormSection(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: [
            FastForm(
              formKey: _formKey,
              onChanged: (value) {
                // ignore: avoid_print
                //  print('Form changed: ${value.toString()}');
                // name = value['name'];
                // email = value['Email'];
                // address = value['address'];
                // phonenumber = value['phonenumber'];
                // distric = value['distric'];
                // state = value['state'];
                // username = value['username'];
                // password = value['password'];
                // refferd = value['refferd'];
                // fee_amount = value['fee_amount'];
                // Payment_type = value['Payment_type'];
                // date_range_pickera = value['date_range_picker'];
                // num_companies = value['num_companies'];
                // paid = value['paid'];
                // status = value['status'];
                // description = value['description'];
                // if (value['date_range_picker'] != null) {
                //   var date_range_pickers = value['date_range_picker'];
                //   final letter = ' 00:00:00.000';
                //   final newLetter = '';
                //   value['date_range_picker'] =
                //       date_range_pickers.replaceAll(letter, newLetter);
                //   // formvalues.add(value['date_range_picker']);
                // }
                // print(value);
                formvalues = [];
                formvalues.add(value);
                // print(formvalues);
              },
              // child: Column(
              children: <Widget>[
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Category'),
                    controller: this._typeAheadController,
                  ),
                  suggestionsCallback: (pattern) async {
                    return await BackendService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, Map<String, String> suggestion) {
                    return ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(suggestion['name']!),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (Map<String, String> suggestion) {
                    String selectedname = suggestion['name'].toString();
                    category_id = suggestion['id'].toString();
                    _typeAheadController.text = selectedname;
                    // Navigator.of(context).push<void>(MaterialPageRoute(
                    //     builder: (context) => ProductPage(product: suggestion))
                    //     );
                  },
                  // onSuggestionSelected: (String suggestion) {
                  //   this._typeAheadController.text = suggestion;
                  // },
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a Customer' : null,
                  onSaved: (value) => this._selectedCity = value,
                ),
                SizedBox(
                  height: 20,
                ),
                FastTextField(
                  name: 'name',
                  labelText: 'Name',
                  placeholder: 'Name',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        3,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),
                FastTextField(
                  name: 'price',
                  labelText: 'price',
                  placeholder: 'price',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 5,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    // Validators.minLength(
                    //     3,
                    //     (_value, minLength) =>
                    //         'Field must contain at least $minLength characters')
                  ]),
                ),
                FastTextField(
                  name: 'description',
                  labelText: 'Description',
                  placeholder: 'Description',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 50,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    // Validators.required((_value) => 'Field is required'),
                    // Validators.minLength(
                    //     3,
                    //     (_value, minLength) =>
                    //         'Field must contain at least $minLength characters')
                  ]),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (category_id.length != 0) {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        // print(formvalues);

                        var name = formvalues[0]['name'];
                        var price = formvalues[0]['price'];
                        var description = formvalues[0]['description'];
                        var finalvalue = jsonEncode(formvalues);
                        await expensescreation(
                                name, price, description, category_id)
                            .then((val) {
                          // print(val);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added Sucessfully')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Expenses(),
                            ),
                          );
                          // (context as Element).reassemble();
                          // Navigator.pop(context, true);

                          // Navigator.of(context).pop();
                          // Navigator.pop(context);
                        });
                      }

                      // await masterlogin(this.formvalues).then((val) {

                      // });

                      // await masterlogin(
                      //         name,
                      //         email,
                      //         address,
                      //         phonenumber,
                      //         distric,
                      //         state,
                      //         username,
                      //         password,
                      //         refferd,
                      //         fee_amount,
                      //         Payment_type,
                      //         date_range_pickera,
                      //         num_companies,
                      //         paid,
                      //         status,
                      //         description)
                      //     .then((val) {
                      //   // print(val);
                      // });

                      // var formData = FormData.fromMap({
                      //   "formsubmit": formvalues,
                      //   "report_action": "master_login",
                      // });

                      // print(formvalues);
                      // var response = await _dio.post(
                      //     'https://kingzquest.com/invoice/api/api.php',
                      //     data: formvalues);

                      // print(response);

                      // formKey.currentState?.reset()
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class MasterForm extends StatefulWidget {
//   MasterForm({Key? key}) : super(key: key);

//   @override
//   State<MasterForm> createState() => _MasterFormState();
// }

// class _MasterFormState extends State<MasterForm> {
//   // final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // child: SingleChildScrollView(
//         //   child: Column(
//         //     children: [
//         //       Form(
//         //         key: _formKey,
//         //         child: Column(
//         //           children: <Widget>[
//         //             TextFormField(
//         //               // The validator receives the text that the user has entered.
//         //               validator: (value) {
//         //                 if (value == null || value.isEmpty) {
//         //                   return 'Please enter some text';
//         //                 }
//         //                 return null;
//         //               },
//         //             ),
//         //             ElevatedButton(
//         //               onPressed: () {
//         //                 if (_formKey.currentState!.validate()) {
//         //                   ScaffoldMessenger.of(context).showSnackBar(
//         //                     const SnackBar(content: Text('Processing Data')),
//         //                   );
//         //                 }
//         //               },
//         //               child: const Text('Submit'),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         );
//   }
// }
String loginuserid = '';
String loginrole = '';

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginuserid = prefs.getString('user_id').toString();
    loginrole = prefs.getString('role').toString();

    var company_id = '';
    var master_id = '';
    if (loginrole == '2') {
      master_id = loginuserid;
    }
    if (loginrole == '3') {
      company_id = loginuserid;
    }
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        'page': '1',
        'name': query,
        'report_action': 'categorylist',
        'master': loginuserid,
        'role': loginrole,
        'isappp': "okay",
        'company_id': company_id,
        'master_id': master_id,
        'size': '-1'
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];

    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;

    var albums = jsonDecode(data);
    // print(albums);
    albums = albums['user_list'];
    // var limit = albums['totalcount'];
    // print(albums);
    // var users = albums['user_list'];
    // print(albums.length);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString(),
          'id': albums[index]['id'].toString(),
        };
      });
    } else {
      return List.generate(1, (index) {
        return {
          'name': 'Empty'.toString(),
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

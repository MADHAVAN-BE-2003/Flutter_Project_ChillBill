import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/apicall.dart';
import 'package:flutter_application_1/common/autocomplete/flutter_typeahead.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersLogin extends StatefulWidget {
  const UsersLogin({Key? key}) : super(key: key);

  @override
  State<UsersLogin> createState() => _UsersLoginState();
}

class _UsersLoginState extends State<UsersLogin> {
  // late Dio _dio;
  final TextEditingController _typeAheadController = TextEditingController();

  String? _selectedcompany;
  String? _selecteditemslist;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final _formKey = GlobalKey<FormState>();
  List formvalues = [];

  var phonenumber = '';
  var username = '';
  var password = '';

  var customer_creation = '';
  var invoice_creation = '';
  var item_creation = '';
  var purchase_creation = '';
  var discription = '';

  var selectedid = '';
  String loginrole = '';
  String loginuserid = '';
  var currentcompanyid = '';
  @override
  void initState() {
    // print("timeeeaaa");
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   print("timeee");
    //   // _data = generateItems(20);
    // });

    super.initState();
    loginusergetstate();
    selectedid = '';
    loginrole = '';
    loginuserid = '';
  }

  loginusergetstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      loginrole = prefs.getString('role').toString();
      loginuserid = prefs.getString('user_id').toString();
    });
  }

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
                print(value);
                formvalues = [];
                formvalues.add(value);
                // print(formvalues);
              },
              // child: Column(
              children: <Widget>[
                if (loginrole == "2" || loginrole == "1") ...[
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Company'),
                      controller: this._typeAheadController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, Map<String, String> suggestion) {
                      return ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(suggestion['name']!),
                        // subtitle: Text('\$${suggestion['price']}'),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Map<String, String> suggestion) {
                      print(suggestion['name']);
                      // var concatenate = StringBuffer();
                      // concatenate.write(suggestion);
                      print(suggestion);
                      selectedid = suggestion['id'].toString();
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
                        value!.isEmpty ? 'Please select a Company' : null,
                    onSaved: (value) => this._selectedcompany = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
                // FastTextField(
                //   name: 'name',
                //   labelText: 'name',
                //   placeholder: 'name',
                //   // keyboardType: TextInputType.datetime,
                //   maxLength: 20,
                //   // prefix: const Icon(Icons.calendar_today),
                //   buildCounter: inputCounterWidgetBuilder,
                //   inputFormatters: const [],
                //   validator: Validators.compose([
                //     Validators.required((_value) => 'Field is required'),
                //     Validators.minLength(
                //         3,
                //         (_value, minLength) =>
                //             'Field must contain at least $minLength characters')
                //   ]),
                // ),

                // validator: Validators.compose([
                //   Validators.required((_value) => 'Field is required'),
                //   // Validators.required((_value) => 'Field is required'),
                //   // EmailValidator.validate(_value);
                //       EmailValidator.validate(value) ? null : "Please enter a valid email",

                //   // Validators.minLength(
                //   //     3,
                //   //     (_value, minLength) =>
                //   //         'Field must contain at least $minLength characters')
                // ]),
                // ),

                FastTextField(
                  name: 'username',
                  labelText: 'UserName',
                  placeholder: 'UserName',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
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
                  name: 'password',
                  labelText: 'PassWord',
                  placeholder: 'PassWord',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
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
                  name: 'phonenumber',
                  labelText: 'PhoneNumber',
                  placeholder: 'PhoneNumber',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 10,
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

                // FastDateRangePicker(
                //   name: 'date_range_picker',
                //   labelText: 'Date Range Picker',
                //   firstDate: DateTime(1970),
                //   lastDate: DateTime(2040),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'customer_creation',
                    labelText: 'customer creation',
                    items: [
                      'yes',
                      'no',
                    ],
                    initialValue: 'no',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'invoice_creation',
                    labelText: 'invoice creation',
                    items: [
                      'yes',
                      'no',
                    ],
                    initialValue: 'no',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'item_creation',
                    labelText: 'item creation',
                    items: [
                      'yes',
                      'no',
                    ],
                    initialValue: 'no',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'purchase_creation',
                    labelText: 'purchase creation',
                    items: [
                      'yes',
                      'no',
                    ],
                    initialValue: 'no',
                  ),
                ),
                FastTextField(
                  name: 'description',
                  labelText: 'Description',
                  placeholder: 'Descriptiont',
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
                    if (loginrole == "3") {
                      currentcompanyid = loginuserid;
                      // selectedid = loginuserid;
                    } else {
                      currentcompanyid = selectedid;
                    }
                    // currentcompanyid = loginuserid;
                    // print(currentcompanyid);
                    if (_formKey.currentState!.validate() &&
                        currentcompanyid != '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      // var companyid = currentcompanyid;
                      var finalvalue = jsonEncode(formvalues);
                      await Userlogin(finalvalue, currentcompanyid).then((val) {
                        // print(val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added Sucessfully')),
                        );
                      });

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

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginuserid = prefs.getString('user_id').toString();
    loginrole = prefs.getString('role').toString();
    // print('companynamelistapp');
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        'name': query,
        'report_action': 'companynamelistapp',
        'master_id': loginuserid,
        'role': loginrole,
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
    // print(albums);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString(),
          'id': albums[index]['id'].toString()
        };
      });
    } else {
      return List.generate(1, (index) {
        return {
          'name': 'Empty'.toString(),
          'id': albums[index]['id'].toString()
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

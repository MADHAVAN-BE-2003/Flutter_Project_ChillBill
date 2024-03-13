import 'package:flutter/material.dart';
import 'package:flutter_application_1/printing1/src/print_job.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/apicall.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/common/autocomplete/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:dio/dio.dart' show Dio, FormData, MultipartFile;
// import 'package:flutter_application_1/pages/company/company.dart';

class CompanyLogin extends StatefulWidget {
  const CompanyLogin({Key? key}) : super(key: key);

  @override
  State<CompanyLogin> createState() => _CompanyLoginState();
}

class _CompanyLoginState extends State<CompanyLogin> {
  var _image;
  var imagePicker;

  final ImagePicker _picker = ImagePicker();

  _onImageButtonPressed() async {
    // }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // print(image);
    // print(image);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _oncameraButtonPressed() async {
    // }
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // print(photo);
    // print(photo);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }
  // late Dio _dio;

  final TextEditingController _typeAheadController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];
  var name = '';
  var email = '';
  var phonenumber = '';
  var username = '';
  var password = '';
  var users_allow = '';
  var sms = '';
  var gst = '';
  var description = '';
  var master_id = '';
  String? _selectedCity;
  late var loginrole = '';

  setrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    setState(() {
      loginrole = loginrole;
    });
  }

  @override
  void initState() {
    setrole();
    // TODO: implement initState
    super.initState();
    print(loginrole);
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
                // print(value['name']);
                formvalues = [];
                formvalues.add(value);
                // print(formvalues);
              },
              // child: Column(
              children: <Widget>[
                loginrole == '1'
                    ? InkWell(
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: false,
                            style: DefaultTextStyle.of(context).style,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Master Login'),
                            controller: this._typeAheadController,
                          ),
                          validator: Validators.compose([
                            Validators.required(
                                (_value) => 'Field is required'),
                          ]),
                          suggestionsCallback: (pattern) async {
                            return await BackendService.getSuggestions(pattern);
                          },
                          itemBuilder:
                              (context, Map<String, String> suggestion) {
                            return ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text(suggestion['username']!),
                              subtitle: Text(suggestion['district']!),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected:
                              (Map<String, String> suggestion) {
                            // print(suggestion);
                            // var concatenate = StringBuffer();
                            // concatenate.write(suggestion);
                            print(suggestion);
                            String selectedname = suggestion['id'].toString();
                            master_id = suggestion['id'].toString();
                            // customername = suggestion['name'].toString() +
                            //     '\n' +
                            //     suggestion['phone'].toString();
                            // String customerphone = suggestion['phone'].toString();
                            // String phone = suggestion['phone'].toString();
                            // String customeraddress = suggestion['address'].toString();
                            // //  List<String> selectedname = suggestion['name'];
                            // phonenumercrl.text = customerphone;
                            // // print(customeraddress);
                            _typeAheadController.text =
                                suggestion['username'].toString();

                            // Navigator.of(context).push<void>(MaterialPageRoute(
                            //     builder: (context) => ProductPage(product: suggestion))
                            //     );
                          },
                          // onSuggestionSelected: (String suggestion) {
                          //   this._typeAheadController.text = suggestion;
                          // },
                          // validator: (value) =>
                          //     value!.isEmpty ? 'Please select a Customer' : null,
                          onSaved: (value) => this._selectedCity = value,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                FastTextField(
                  name: 'name',
                  labelText: 'name',
                  placeholder: 'name',
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
                  name: 'Email',
                  labelText: 'Email',
                  placeholder: 'Email',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 30,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _onImageButtonPressed();
                      },
                      child: const Text('image from gallery'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _oncameraButtonPressed();
                      },
                      child: const Text('Take a Photo'),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 247, 243, 243)),
                  child: _image != null
                      ? Image.file(
                          _image,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 247, 245, 245)),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                // FastDateRangePicker(
                //   name: 'date_range_picker',
                //   labelText: 'Date Range Picker',
                //   firstDate: DateTime(1970),
                //   lastDate: DateTime(2040),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FastDropdown<String>(
                    name: 'users_allow',
                    labelText: 'No of Users Allow',
                    items: const [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10'
                    ],
                    initialValue: '1',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'gst',
                    labelText: 'GST',
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
                    name: 'sms',
                    labelText: 'SMS',
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
                    var sub = true;

                    if (loginrole == '1') {
                      // print(master_id);
                      // print("master_id empty");
                      if (master_id == '' ||
                          master_id == 'null' ||
                          master_id.length == 0) {
                        sub = false;
                      }
                    }

                    if (_formKey.currentState!.validate() && sub == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      loginuserid = prefs.getString('user_id').toString();
                      loginrole = prefs.getString('role').toString();
                      var finalvalue = jsonEncode(formvalues);
                      var formData = FormData.fromMap({
                        'report_action': 'company_login',
                        'master': loginuserid,
                        'role': loginrole,
                        'formvalues': finalvalue,
                        'formsubmit': 'company_login',
                        "logo_image": await MultipartFile.fromFile(_image!.path,
                            filename: _image!.path)
                      });
                      var response = await Dio().post(
                          'https://kingzquest.com/invoice/api/api.php',
                          data: formData);
                      // print(master_id);
                      // print("formvalues");
                      // var finalvalue = jsonEncode(formvalues);
                      // await Companylogin(finalvalue, master_id).then((val) {
                      //   // print(val);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Added Sucessfully')),
                      //   );
                      // Navigator.push(
                      //   context,
                      //   // MaterialPageRoute(builder: (context) => Additems()),
                      //   MaterialPageRoute(builder: (context) => Company()),
                      // );
                      formvalues = [];
                      name = '';
                      email = '';
                      phonenumber = '';
                      username = '';
                      password = '';
                      users_allow = '';
                      sms = '';
                      gst = '';
                      description = '';
                      master_id = '';
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added Sucessfully')),
                      );
                      // });

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
    // print("Asdasdasd");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // loginuserid = prefs.getString('user_id').toString();
    // loginrole = prefs.getString('role').toString();
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        // 'search': query,
        // 'report_action': 'masterloginlist',
        // 'master_id': loginuserid,
        // 'loginrole': loginrole,
        'size': '-1',
        'sortBy': '',
        'sortDesc': 'false',
        'page': '-1',
        'search': query,
        'datesearch': '',
        'report_action': 'masterloginlist'
      },
    );
    // print(response.body);
    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];
    // print(response);
    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;

    // print(data);

    var albums = jsonDecode(data);

    albums = albums['user_list'];
    // var limit = albums['totalcount'];
    print(albums);
    // var users = albums['user_list'];
    // print(albums.length);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'username': albums[index]['username'].toString(),
          'id': albums[index]['user_id'].toString(),
          'district': albums[index]['district'].toString(),
        };
      });
    } else {
      return List.generate(1, (index) {
        return {'username': 'Empty'.toString(), 'id': 's', 'district': 's'};
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

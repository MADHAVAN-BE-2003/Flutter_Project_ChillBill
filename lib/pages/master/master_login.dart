import 'package:chill_bill/common/api_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';

import 'dart:convert';

class MatserLogin extends StatefulWidget {
  const MatserLogin({Key? key}) : super(key: key);

  @override
  State<MatserLogin> createState() => _MatserLoginState();
}

class _MatserLoginState extends State<MatserLogin> {
  // late Dio _dio;
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];
  var name = '';
  var email = '';
  var address = '';
  var phonenumber = '';
  var distric = '';
  var state = '';
  var username = '';
  var password = '';
  var refferd = '';
  var fee_amount = '';
  var Payment_type = '';
  var date_range_pickera = '';
  var num_companies = '';
  var paid = '';
  var status = '';
  var description = '';

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
                  name: 'address',
                  labelText: 'Address',
                  placeholder: 'Address',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 30,
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
                FastTextField(
                  name: 'distric',
                  labelText: 'Distric',
                  placeholder: 'Distric',
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
                  name: 'state',
                  labelText: 'State',
                  placeholder: 'State',
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
                  name: 'refferd',
                  labelText: 'Refferd By',
                  placeholder: 'Refferd By',
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
                // FastAutocomplete<String>(
                //   name: 'autocomplete',
                //   labelText: 'No of Companies Allow',
                //   options: const ['1', '2', '3', '4'],
                // ),
                FastTextField(
                  name: 'fee_amount',
                  labelText: 'Fee Amount',
                  placeholder: 'Fee Amount',
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
                  name: 'Payment_type',
                  labelText: 'Payment Type',
                  placeholder: 'Payment Type',
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
                // FastDateRangePicker(
                //   name: 'date_range_picker',
                //   labelText: 'Date Range Picker',
                //   firstDate: DateTime(1970),
                //   lastDate: DateTime(2040),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FastDropdown<String>(
                    name: 'num_companies',
                    labelText: 'No of Companies Allow',
                    items: const ['1', '2', '3', '4'],
                    initialValue: '1',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'paid',
                    labelText: 'Paid',
                    items: [
                      'yes',
                      'no',
                    ],
                    initialValue: 'yes',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FastDropdown<String>(
                    name: 'status',
                    labelText: 'Status',
                    items: ['Active', 'Deactive'],
                    initialValue: 'Active',
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
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      print(formvalues);
                      var finalvalue = jsonEncode(formvalues);
                      await masterlogin(finalvalue).then((val) {
                        print(val);
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

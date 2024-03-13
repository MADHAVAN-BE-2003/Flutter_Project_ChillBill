import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/apicall.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ItemCreate extends StatefulWidget {
  const ItemCreate({Key? key}) : super(key: key);

  @override
  State<ItemCreate> createState() => _ItemCreateState();
}

class _ItemCreateState extends State<ItemCreate> {
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];

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
                // FastTextField(
                //   name: 'phone',
                //   labelText: 'PhoneNumber',
                //   placeholder: 'PhoneNumber',
                //   // keyboardType: TextInputType.datetime,
                //   maxLength: 10,
                //   // prefix: const Icon(Icons.calendar_today),
                //   buildCounter: inputCounterWidgetBuilder,
                //   inputFormatters: const [],
                //   validator: Validators.compose([
                //     Validators.required((_value) => 'Field is required'),
                //     // Validators.minLength(
                //     //     3,
                //     //     (_value, minLength) =>
                //     //         'Field must contain at least $minLength characters')
                //   ]),
                // ),
                FastTextField(
                  name: 'description',
                  labelText: 'Description',
                  placeholder: 'description',
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

                      // var finalvalue = jsonEncode(formvalues);
                      var name = formvalues[0]['name'];
                      var description = formvalues[0]['description'];
                      await productcategorycreation(name, description)
                          .then((val) {
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

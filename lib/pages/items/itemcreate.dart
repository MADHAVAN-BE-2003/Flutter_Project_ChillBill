// ignore_for_file: unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:dio/dio.dart';
import 'package:chill_bill/common/api_call.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io' show File;
import 'package:dio/dio.dart' show Dio, FormData, MultipartFile;
import 'package:chill_bill/common/auto_complete/flutter_typeahead.dart';

// import './ImageFromGalleryEx.dart';

enum ImageSourceType { gallery, camera }

class ItemCreate extends StatefulWidget {
  const ItemCreate({Key? key}) : super(key: key);

  @override
  State<ItemCreate> createState() => _ItemCreateState();
}

class _ItemCreateState extends State<ItemCreate> {
  // late Dio _dio;
  // ItemCreate() {
  //   _dio = Dio();
  // }

  final _formKey = GlobalKey<FormState>();
  List formvalues = [];

  var discription = '';
  var name = '';
  var minStockqty = '';
  var openingstock = '';
  var tax = '';
  var saleprice = '';
  var purchaseprice = '';
  var discount = '';
  var code = '';
  var unit_size = '';
  // var _image;
  var _image;
  var imagePicker;
  var type;
  var selectedid = '';
  var selectedid_unit = '';
  String? _selectedcompany;
  String? _selectedunit;
//   List<XFile>? _imageFileList;

// void _setImageFileListFromFile(XFile? value) {
//   _imageFileList = value == null ? null : <XFile>[value];
// }

// dynamic _pickImageError;
// bool isVideo = false;

// String? _retrieveDataError;
  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  // final ImagePicker _picker = ImagePicker();
// final TextEditingController maxWidthController = TextEditingController();
// final TextEditingController maxHeightController = TextEditingController();
// final TextEditingController qualityController = TextEditingController();

  // void _handleURLButtonPress(BuildContext context, var type) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  // }
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadControllerunit =
      TextEditingController();

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

  // Future<void> _onImageButtonPressed(ImageSource source,
  //     {BuildContext? context, bool isMultiImage = false}) async {
  //   // if (_controller != null) {
  //   //   await _controller.setVolume(0.0);
  //   // }
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  //   // await _displayPickImageDialog(context!,
  //   //     (double? maxWidth, double? maxHeight, int? quality) async {
  //   //   try {
  //   //     final XFile? pickedFile = await _picker.pickImage(
  //   //       source: source,
  //   //       maxWidth: maxWidth,
  //   //       maxHeight: maxHeight,
  //   //       imageQuality: quality,
  //   //     );
  //   //     setState(() {
  //   //       _setImageFileListFromFile(pickedFile);
  //   //     });
  //   //   } catch (e) {
  //   //     setState(() {
  //   //       _pickImageError = e;
  //   //     });
  //   //   }
  //   // });
  // }

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
                    // style: DefaultTextStyle.of(context)
                    //     .style
                    //     .copyWith(fontStyle: FontStyle.italic),
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
                      value!.isEmpty ? 'Please select a category' : null,
                  onSaved: (value) => this._selectedcompany = value,
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
                  // validator: Validators.compose([
                  //   Validators.required((_value) => 'Field is required'),
                  //   Validators.minLength(
                  //       3,
                  //       (_value, minLength) =>
                  //           'Field must contain at least $minLength characters')
                  // ]),
                ),

                FastTextField(
                  name: 'code',
                  labelText: 'Code',
                  placeholder: 'Code',
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

                // MaterialButton(
                //   color: Colors.blue,
                //   child: Text(
                //     "Pick Image from Gallery",
                //     style: TextStyle(
                //         color: Colors.white70, fontWeight: FontWeight.bold),
                //   ),
                //   onPressed: () {
                //     _handleURLButtonPress(context, ImageSourceType.gallery);
                //   },
                // ),
                // MaterialButton(
                //   color: Colors.blue,
                //   child: Text(
                //     "Pick Image from Camera",
                //     style: TextStyle(
                //         color: Colors.white70, fontWeight: FontWeight.bold),
                //   ),
                //   onPressed: () {
                //     _handleURLButtonPress(context, ImageSourceType.camera);
                //   },
                // ),
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

                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    // style: DefaultTextStyle.of(context)
                    //     .style
                    //     .copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Unit'),
                    controller: this._typeAheadControllerunit,
                  ),
                  suggestionsCallback: (pattern) async {
                    return await BackendService_unit.getSuggestions(pattern);
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
                    // var concatenate = StringBuffer();
                    // concatenate.write(suggestion);

                    selectedid_unit = suggestion['id'].toString();
                    print(selectedid_unit);
                    String selectedname = suggestion['name'].toString();
                    //  List<String> selectedname = suggestion['name'];
                    this._typeAheadControllerunit.text = selectedname;
                    // Navigator.of(context).push<void>(MaterialPageRoute(
                    //     builder: (context) => ProductPage(product: suggestion))
                    //     );
                  },
                  // onSuggestionSelected: (String suggestion) {
                  //   this._typeAheadController.text = suggestion;
                  // },
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a Unit' : null,
                  onSaved: (value) => this._selectedunit = value,
                ),
                SizedBox(
                  height: 20,
                ),
                // Semantics(
                //   label: 'image_picker_example_from_gallery',
                //   child: FloatingActionButton(
                //     onPressed: () {
                //       _onImageButtonPressed();
                //     },
                //     heroTag: 'image0',
                //     tooltip: 'Pick Image from gallery',
                //     child: const Icon(Icons.photo),
                //   ),
                // ),
                FastTextField(
                  name: 'unit_size',
                  labelText: 'Unit Size',
                  placeholder: 'Unit Size',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 10,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),
                FastTextField(
                  name: 'purchaseprice',
                  labelText: 'Purchase Price',
                  placeholder: 'Purchase Price',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),

                FastTextField(
                  name: 'saleprice',
                  labelText: 'Sale Price',
                  placeholder: 'Sale Price',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),

                FastTextField(
                  name: 'discount',
                  labelText: 'Discount',
                  placeholder: 'Discount',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),

                FastTextField(
                  name: 'tax',
                  labelText: 'Tax',
                  placeholder: 'Tax',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),
                FastTextField(
                  name: 'openingstock',
                  labelText: 'Opening Stock',
                  placeholder: 'Opening Stock',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
                ),
                FastTextField(
                  name: 'minStockqty',
                  labelText: 'Min Stock Qty',
                  placeholder: 'Min Stock Qty',
                  // keyboardType: TextInputType.datetime,
                  maxLength: 20,
                  // prefix: const Icon(Icons.calendar_today),
                  buildCounter: inputCounterWidgetBuilder,
                  inputFormatters: const [],
                  validator: Validators.compose([
                    Validators.required((_value) => 'Field is required'),
                    Validators.minLength(
                        1,
                        (_value, minLength) =>
                            'Field must contain at least $minLength characters')
                  ]),
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

                      var finalvalue = jsonEncode(formvalues);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      loginuserid = prefs.getString('user_id').toString();
                      loginrole = prefs.getString('role').toString();

                      // var request = http.MultipartRequest(
                      //     'POST',
                      //     Uri.parse(
                      //         'https://kingzquest.com/invoice/api/api.php'));
                      // request.fields['report_action'] = 'item_create';
                      // request.fields['master'] = loginuserid;
                      // request.fields['role'] = loginrole;
                      // request.fields['formvalues'] = finalvalue;
                      // request.fields['formsubmit'] = 'itemcreate';
                      // request.files.add(http.MultipartFile.fromBytes(
                      //     'product_image', File(_image!.path).readAsBytesSync(),
                      //     filename: _image!.path));
                      // var response = await request.send();

                      // var bytes = File(_image!.path).readAsBytesSync();

                      // var response = await http.post(
                      //     Uri.parse(
                      //         'https://kingzquest.com/invoice/api/api.php'),
                      //     headers: {"Content-Type": "multipart/form-data"},
                      //     body: {"lang": "fas", "image": bytes},
                      //     encoding: Encoding.getByName("utf-8"));

                      // return response.body;
                      // FormData formData = new FormData.from({
                      //   "name": "wendux",
                      //   "file1": new UploadFileInfo(
                      //       new File(_image!.path), "upload1.jpg")
                      // });

                      var formData = FormData.fromMap({
                        'report_action': 'item_create',
                        'master': loginuserid,
                        'role': loginrole,
                        'formvalues': finalvalue,
                        'category': selectedid,
                        'unit': selectedid_unit,
                        'formsubmit': 'itemcreate',
                        "product_image": await MultipartFile.fromFile(
                            _image!.path,
                            filename: _image!.path)
                      });
                      var response = await Dio().post(
                          'https://kingzquest.com/invoice/api/api.php',
                          data: formData);
                      print("response");
                      print(response);

                      // print(File(_image!.path).readAsBytesSync());
                      // print(response);
                      // await itemcreation(finalvalue, _image).then((val) {
                      //   // print(val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added Sucessfully')),
                      );
                      // });

                      // formvalues = [];
                      // discription = '';
                      // name = '';
                      // minStockqty = '';
                      // openingstock = '';
                      // tax = '';
                      // saleprice = '';
                      // purchaseprice = '';
                      // discount = '';
                      // code = '';
                      // unit_size = '';
                      // selectedid = '';
                      // selectedid_unit = '';
                      // _selectedcompany = '';
                      // _selectedunit = '';

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

class UploadFileInfo {}

// typedef OnPickImageCallback = void Function(
//     double? maxWidth, double? maxHeight, int? quality);

// class AspectRatioVideo extends StatefulWidget {
//   const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);

//   final VideoPlayerController? controller;

//   @override
//   AspectRatioVideoState createState() => AspectRatioVideoState();
// }

// class AspectRatioVideoState extends State<AspectRatioVideo> {
//   VideoPlayerController? get controller => widget.controller;
//   bool initialized = false;

//   void _onVideoControllerUpdate() {
//     if (!mounted) {
//       return;
//     }
//     if (initialized != controller!.value.isInitialized) {
//       initialized = controller!.value.isInitialized;
//       setState(() {});
//     }
//   }

// Future<void> _displayPickImageDialog(
//     BuildContext context, OnPickImageCallback onPick) async {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add optional parameters'),
//           content: Column(
//             children: <Widget>[
//               TextField(
//                 controller: maxWidthController,
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 decoration: const InputDecoration(
//                     hintText: 'Enter maxWidth if desired'),
//               ),
//               TextField(
//                 controller: maxHeightController,
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 decoration: const InputDecoration(
//                     hintText: 'Enter maxHeight if desired'),
//               ),
//               TextField(
//                 controller: qualityController,
//                 keyboardType: TextInputType.number,
//                 decoration:
//                     const InputDecoration(hintText: 'Enter quality if desired'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('CANCEL'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//                 child: const Text('PICK'),
//                 onPressed: () {
//                   final double? width = maxWidthController.text.isNotEmpty
//                       ? double.parse(maxWidthController.text)
//                       : null;
//                   final double? height = maxHeightController.text.isNotEmpty
//                       ? double.parse(maxHeightController.text)
//                       : null;
//                   final int? quality = qualityController.text.isNotEmpty
//                       ? int.parse(qualityController.text)
//                       : null;
//                   onPick(width, height, quality);
//                   Navigator.of(context).pop();
//                 }),
//           ],
//         );
//       });
// }

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var master_id = '';
    var company_id = '';
    loginrole = prefs.getString('role').toString();
    if (loginrole == 2) {
      master_id = prefs.getString('user_id').toString();
    }
    if (loginrole == 3) {
      company_id = prefs.getString('user_id').toString();
    }
    // print('companynamelistapp');
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        'name': query,
        'report_action': 'item_categorylist',
        'master_id': master_id == '1' ? '' : master_id,
        'company_id': company_id == '1' ? '' : company_id,
        'role': loginrole,
        'size': '-1'
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];

    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;
    // print(data);

    var albums = jsonDecode(data);
    albums = albums['user_list'];
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

class BackendService_unit {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var master_id = '';
    var company_id = '';
    loginrole = prefs.getString('role').toString();
    if (loginrole == 2) {
      master_id = prefs.getString('user_id').toString();
    }
    if (loginrole == 3) {
      company_id = prefs.getString('user_id').toString();
    }
    // print('companynamelistapp');
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        'name': query,
        'report_action': 'item_unitlist',
        'master_id': master_id == '1' ? '' : master_id,
        'company_id': company_id == '1' ? '' : company_id,
        'role': loginrole,
        'size': '-1'
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];

    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;
    // print(data);

    var albums = jsonDecode(data);
    albums = albums['user_list'];
    // var limit = albums['totalcount'];
    // print(albums);
    // var users = albums['user_list'];
    // print(albums);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString() +
              ' ' +
              albums[index]['short'].toString(),
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

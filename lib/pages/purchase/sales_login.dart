// ignore_for_file: unused_import, unused_field, unused_local_variable

import 'package:chill_bill/pages/purchase/product_grid_k.dart';
import 'package:chill_bill/pages/sales/thermal_printer.dart';
import 'package:chill_bill/pdf/api/pdf_invoice_api.dart';
import 'package:chill_bill/pdf/model/customer.dart';
import 'package:chill_bill/pdf/model/invoice.dart';
import 'package:chill_bill/pdf/model/supplier.dart';
// import 'package:flutter_application_1/pages/purchase/thermal_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:chill_bill/common/auto_complete/flutter_typeahead.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:math';
// import 'package:flutter_application_1/pages/sales/add_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/createpdf/page/pdf_page.dart';
// import 'package:flutter_application_1/createpdf/model/customer.dart';
// import 'package:flutter_application_1/createpdf/model/invoice.dart';
// import 'package:flutter_application_1/createpdf/model/supplier.dart';
// import 'package:flutter_application_1/createpdf/api/pdf_api.dart';
// import 'package:flutter_application_1/createpdf/api/pdf_print.dart';
import 'package:chill_bill/pdf/api/pdf_invoice_print.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter_application_1/pages/purchase/productgrid.dart';
import 'package:intl/intl.dart';
import 'package:chill_bill/common/api_call.dart';
import 'package:localstorage/localstorage.dart';

final storage = new LocalStorage('store_product_purchase');

// C:\flutterprojects\invoice_build\flutter_application_1\lib\pages\sales\Productgridk.dart

class SalesLogin extends StatefulWidget {
  const SalesLogin({Key? key}) : super(key: key);

  @override
  State<SalesLogin> createState() => _SalesLoginState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.headerquentity,
    required this.headertax,
    required this.headerid,
    required this.headercode,
    required this.headertotal,
    required this.grandtotal,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String headercode;
  String headerquentity;
  String headertax;
  String headerid;
  String headertotal;
  String grandtotal;
  bool isExpanded;
}

List formvalues = [];
int _selectedItems = 0;
var itemslistarray = [];
var qty = [];
var billing_name = '';
var billing_address = '';
var company_phone = '';
var clearallselprot = false;
var customername = '';
var customeraddress = '';
var customerphone = '';
var _total = itemslistarray.length != 0
    ? itemslistarray.map<double>((p) => p.headertotal).reduce((a, b) => a + b)
    : '0';
String loginuserid = '';
String loginrole = '';
String salesinvoicesearch = '';

String overalltotal = _total.toString();
List<Item> generateItems(int numberOfItems) {
  // print("itemslistarray");
  // print(itemslistarray);
  // print("itemslistarray");
  final fruitMap = itemslistarray.asMap();

  // print("itemssssssssssssssss");
  return List<Item>.generate(itemslistarray.length, (int index) {
    return Item(
      // itemslistarray[index]['headerValue'].toString()
      headerValue: fruitMap[index]['headerValue'].toString(),
      expandedValue: 'price : ' + fruitMap[index]['headerprice'].toString(),
      headerquentity: fruitMap[index]['headerquentity'].toString(),
      headercode: fruitMap[index]['headercode'].toString(),
      headertax: fruitMap[index]['headertax'].toString(),
      headerid: fruitMap[index]['headerid'].toString(),
      headertotal: fruitMap[index]['headertotal'].toString(),
      grandtotal: fruitMap[index]['grandtotal'].toString(),
    );
  });
}

class _SalesLoginState extends State<SalesLogin> {
  @override
  void initState() {
    // print("timeeeaaa");
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   print("timeee");
    //   // _data = generateItems(20);
    // });

    super.initState();
    _initCheck();
    _removeitemslistarray();
  }

  _removeitemslistarray() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    billing_name = prefs.getString('billing_name').toString();
    billing_address = prefs.getString('billing_address').toString();
    // var _total = '0';
    // if (itemslistarray.length != 0) {
    //   var _total = itemslistarray
    //       .map<double>((p) => p.headertotal)
    //       .reduce((a, b) => a + b);
    // }

    setState(() {
      itemslistarray = [];
      qty = [];
      overalltotal = _total.toString();
      clearallselprot = false;
    });
  }

  // final List<Item> _data = generateItems(20);

  // late Dio _dio;
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;

  int _selectedIndex = 0;
  String? pathImage;
  Thermal? thermalPrint;
  // String _phone = '7777';
  List<Item> _data = [];
  TextEditingController phonenumercrl = new TextEditingController();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    // Text(
    //   'Index 2: School',
    //   style: optionStyle,
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      backgroundColor: Colors.deepPurple,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.0)));

  void _initCheck() async {
    thermalPrint = Thermal();
    // SingleChildScrollView.of(context).rebuild();
    // _data = generateItems(20);
    //  _buildPanel.of(context).rebuild();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('itemname'));
    // if (prefs.getString('itemname') != null) {
    //   print("_selectedItems");
    //   setState(() {
    //     // user = prefs.getBool('user');
    //     _selectedItems = _selectedItems + 1;
    //   });
    //   prefs.remove('itemname');
    // }

    // print(_selectedItems);
    // Scaffold.of(context).rebuild();
    // storage.setItem('store_product_list', []);

    if (storage.getItem("store_product_list") != null) {
      //  alert('yes');
      print("localsdtore");
      var product = storage.getItem('store_product_list');

      itemslistarray = product;

      print(itemslistarray);
    }
    // var product = storage.getItem('store_product_list');
    // if (itemslistarray.length == 0) {

    // }

    _data = generateItems(itemslistarray.length);
    // _buildPanel();

    // save_pref_product(itemslistarray);
  }

  set_clear_prduct_count() {
    storage.setItem('store_selectedListid_count', []);
  }

  save_pref_product() {
    // final info = json.encode(itemslistarray);
    storage.setItem('store_product_list', itemslistarray);

    // storage.setItem('store_product_list', itemslistarray);

    // var product = storage.getItem('store_product_list');

    // print(product);
    // final store = await SharedPreferences.getInstance();
    //   store.setString
    // store.setStringList('stored_product', itemslistarray);

    // print(itemslistarray);
    // store.('store_product', itemslistarray);
  }

  createprint() async {
    // final store = await SharedPreferences.getInstance();
    // thermalprint

    // var regularprint = store.getBool('regularprint');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    // var invoice_itemss = itemslistarray.map((list) => Tab(text: list.headerValue)).toList();
    if (itemslistarray.length != 0) {
      // var invoice_items = InvoiceItem(
      //   description: 'Coffee',
      //   date: DateTime.now(),
      //   quantity: 3,
      //   vat: 0.19,
      //   unitPrice: 5.99,
      // );
      // print("print_aaaaaaaaaaaalistttt");
      var invoice_items = itemslistarray.map((item) {
        var lat2 = double.parse(item['headerprice']);
        return InvoiceItem(
          description: item['headerValue'].toString(),
          date: DateTime.now(),
          quantity: 1,
          vat: 0.19,
          unitPrice: lat2,
        );

        // print(item['headerValue']);
        // print("print_listttt");
        // return "asdasdasd";
      }).toList();
      // var asd = invoice_itemss;
      var invoice = Invoicenormal(
        supplier: Supplier(
          name: billing_name,
          address: billing_address,
          paymentInfo: '',
        ),
        customer: Customer(
          name: customername,
          address: customeraddress + '/n/' + customerphone,
        ),
        info: InvoiceInfo(
          date: date,
          dueDate: dueDate,
          description: 'My description...',
          number: '${DateTime.now().year}-9999',
        ),
        // items: itemlisting(),
        items: invoice_items,
      );
      //  print(prefs.getBool('normalregularprint'));
      //   print(prefs.getBool('regularprint'));
      bool? normalprint = prefs.getBool('regularprint');
      if (normalprint == true) {
        bool? normalregularprint = prefs.getBool('normalregularprint');

        if (normalregularprint == true) {
          var pdfFile = await PdfInvoiceApi.generate(invoice);
          // final pdfFile = await generatepdfprint(
          //     itemslistarray, billing_name, billing_address);
        } else {
          final pdfFile = await generatepdfprint(
              itemslistarray,
              billing_name,
              billing_address,
              customername,
              customeraddress + '/n/' + customerphone);
        }
      }
      final filename = 'yourlogo.png';
      var bytes = await rootBundle.load("assets/images/yourlogo.png");
      String dir = (await getApplicationDocumentsDirectory()).path;
      writeToFile(bytes, '$dir/$filename');

      setState(() {
        pathImage = '$dir/$filename';
      });
      bool? thermalprint = prefs.getBool('thermalprint');
      if (thermalprint == true) {
        thermalPrint?.getprint(
            itemslistarray,
            pathImage!,
            billing_name,
            billing_address,
            customername,
            customeraddress + '/n/' + customerphone);
      }
      //  pathImage = '$dir/$filename';

      // await Printing.layoutPdf(
      //     onLayout: (PdfPageFormat format) async => pdfFile.save());
      // final pdfFile = await generatepdfprint();

      // print(pdfFile);
//       final output = await getTemporaryDirectory();
// final file = File('${output.path}/example.pdf');
// await file.writeAsBytes(await doc.save());
      // final file = File(pdfFile);
      // await file.writeAsBytes(await pdfFile.save());
      // PdfApi.openFile(pdfFile);
      // PdfApi();
      // this.onPrinted();
      // await Printing.layoutPdf(
      // onLayout: (PdfPageFormat format) async => pdfFile.save());
      // await pdfFile.save();
      // itemslistarray = [];

      setState(() {
        storage.setItem('store_product_list', []);
        clearallselprot = true;
        // Call setState to refresh the page.
        _initCheck();
      });
      _typeAheadController.text = '';
      phonenumercrl.text = '';
      overalltotal = '0';
    }
  }

  // itemlisting() {
  //   return InvoiceItem(
  //     description: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  //     date: DateTime.now(),
  //     quantity: 3,
  //     vat: 0.19,
  //     unitPrice: 5.99,
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Stack(
      //   children: [
      //     new Container(
      //       height: 100.0,
      //       color: Colors.green,
      //     ),
      //     Positioned(
      //       left: 0.0,
      //       right: 0.0,
      //       top: 0.0,
      //       bottom: 0.0,
      //       child: new CustomPaint(
      //         painter: Painter(),
      //         size: Size.infinite,
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        padding: const EdgeInsets.only(
            bottom: 70.0, top: 16.0, right: 16.0, left: 16.0),
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
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Customer'),
                      controller: this._typeAheadController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, Map<String, String> suggestion) {
                      return ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(suggestion['name']!),
                        subtitle: Text(suggestion['phone']!),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Map<String, String> suggestion) {
                      print(suggestion);
                      // var concatenate = StringBuffer();
                      // concatenate.write(suggestion);
                      String selectedname = suggestion['name'].toString();
                      customername = suggestion['name'].toString() +
                          '\n' +
                          suggestion['phone'].toString();
                      String customerphone = suggestion['phone'].toString();
                      String phone = suggestion['phone'].toString();
                      String customeraddress = suggestion['address'].toString();
                      //  List<String> selectedname = suggestion['name'];
                      phonenumercrl.text = customerphone;
                      // print(customeraddress);
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
                  TextField(
                    readOnly: true,
                    controller: phonenumercrl,
                    decoration: InputDecoration(
                      hintText: 'PhoneNumber',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(0.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  // FastTextField(
                  //   name: 'phonenumber',
                  //   labelText: 'PhoneNumber',
                  //   placeholder: 'PhoneNumber',
                  //   initialValue: _phone.toString(),
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    // Column(
                    children: <Widget>[
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () async {
                          // var _startingTabCount = 0;
                          // var category_list = [];

                          storage.setItem('store_product_list', []);

                          // var producatt = [];
                          // producatt = storage.getItem('store_selectedListid');
                          // // producatt = [];
                          // producatt.forEach((element) {
                          //   print('store_selectedListid');
                          //   print(element);
                          //   // producatt.remove(element);
                          // });
                          // var producattg = [];
                          // producattg =
                          //     storage.getItem('store_selectedListid_count');
                          // // producattg = [];
                          // var i = 0;
                          // producattg.forEach((element) {
                          //   print('store_selectedListid');
                          //   print(element);
                          //   // producattg.remove(element);
                          //   producattg..removeAt(i);
                          //   i++;
                          // });

                          // storage.deleteItem('store_selectedListid');
                          // storage.deleteItem('store_selectedListid_count');
                          setState(() {
                            // Call setState to refresh the page.
                            // set_clear_prduct_count();
                            clearallselprot = true;
                            _initCheck();
                            itemslistarray = [];
                            qty = [];
                            overalltotal = _total.toString();
                          });
                        },
                        child: Text('Clear'),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Text(
                        "Total: " + overalltotal,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 18, 14, 231)),
                      ),
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () async {
                          final store = await SharedPreferences.getInstance();
                          if (store.getBool('productgrid') == null) {
                            store.setBool('productgrid', false);
                          }
                          bool? productgridstatus =
                              store.getBool('productgrid');

                          if (productgridstatus == true) {
                            var _startingTabCount = 0;
                            var category_list = [];
                            var products_list = [];
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            loginrole = prefs.getString('role').toString();
                            loginuserid = prefs.getString('user_id').toString();
                            salesinvoicesearch = prefs
                                .getString('salesinvoicesearch')
                                .toString();

                            var master_id = '';
                            var company_id = '';
                            if (loginrole == '2') {
                              master_id = loginrole;
                            }
                            if (loginrole == '3') {
                              company_id = loginrole;
                            }

                            var queryParameters = {
                              // "page": paginate.page.toString(),
                              // "limit": paginate.limit.toString(),
                              "report_action": "product_list_grid",
                              // "size": paginate.limit.toString(),
                              "sortBy": '',
                              "sortDesc": 'false',
                              "master_id": master_id.toString(),
                              "search": salesinvoicesearch.toString(),
                              "company_id": company_id.toString()
                            };

                            var response = await http.post(
                              Uri.parse(
                                  'http://invoice.kingzquest.com/api/api.php'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/x-www-form-urlencoded',
                              },
                              body: queryParameters,
                            );
                            var result_data = jsonDecode(response.body);

                            print("|api");
                            _startingTabCount =
                                result_data['category_list_count'];
                            // print(result_data['category_list_count']);
                            // print(result_data['category_list']);
                            category_list = result_data['category_list'];

                            products_list = result_data['product_list'];

                            // print(result_data);

                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => Additems()),
                              MaterialPageRoute(
                                  builder: (context) => Productgridk(
                                        startingTabCountapp: _startingTabCount,
                                        category_listapp: category_list,
                                        products_listapp: products_list,
                                        clearall: clearallselprot,
                                      )),
                            ).then((_) {
                              setState(() {
                                // Call setState to refresh the page.
                                // save_pref_product();
                                clearallselprot = false;
                                _initCheck();
                              });
                              // This block runs when you have returned back to the 1st Page from 2nd.
                            });
                            // final additems = Productgrid();
                            // Navigator.push(
                            //   context,
                            //   // MaterialPageRoute(builder: (context) => Additems()),
                            //   MaterialPageRoute(
                            //       builder: (context) => Productgrid()),
                            // ).then((_) {
                            //   // This block runs when you have returned back to the 1st Page from 2nd.
                            //   setState(() {
                            //     // Call setState to refresh the page.
                            //     _initCheck();
                            //   });
                            // });
                          } else {
                            // final additems = Additems();
                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => Additems()),
                              MaterialPageRoute(
                                  builder: (context) => Additems()),
                            ).then((_) {
                              // This block runs when you have returned back to the 1st Page from 2nd.
                              setState(() {
                                // Call setState to refresh the page.
                                save_pref_product();
                                _initCheck();
                              });
                            });
                          }

                          //                       Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => Additems())).then((_) {
                          //   // This block runs when you have returned back to the 1st Page from 2nd.
                          //   setState(() {
                          //     // Call setState to refresh the page.
                          //   });
                          // });
                        },
                        child: Text('Add Items'),
                      ),
                      // ElevatedButton(
                      //   style: raisedButtonStyle,
                      //   onPressed: () async {
                      //     var _startingTabCount = 0;
                      //     var category_list = [];

                      //     Navigator.push(
                      //       context,
                      //       // MaterialPageRoute(builder: (context) => Additems()),
                      //       MaterialPageRoute(
                      //           builder: (context) => Productgridkk(
                      //                 startingTabCountapp: _startingTabCount,
                      //                 category_listapp: category_list,
                      //               )),
                      //     ).then((_) {
                      //       // This block runs when you have returned back to the 1st Page from 2nd.
                      //     });
                      //   },
                      //   child: Text('Add Items new'),
                      // ),
                      // ElevatedButton(
                      //   style: raisedButtonStyle,
                      //   onPressed: () async {
                      //     var _startingTabCount = 0;
                      //     var category_list = [];
                      //     var products_list = [];
                      //     SharedPreferences prefs =
                      //         await SharedPreferences.getInstance();
                      //     loginrole = prefs.getString('role').toString();
                      //     loginuserid = prefs.getString('user_id').toString();
                      //     salesinvoicesearch =
                      //         prefs.getString('salesinvoicesearch').toString();

                      //     var master_id = '';
                      //     var company_id = '';
                      //     if (loginrole == '2') {
                      //       master_id = loginrole;
                      //     }
                      //     if (loginrole == '3') {
                      //       company_id = loginrole;
                      //     }

                      //     var queryParameters = {
                      //       // "page": paginate.page.toString(),
                      //       // "limit": paginate.limit.toString(),
                      //       "report_action": "product_list_grid",
                      //       // "size": paginate.limit.toString(),
                      //       "sortBy": '',
                      //       "sortDesc": 'false',
                      //       "master_id": master_id.toString(),
                      //       "search": salesinvoicesearch.toString(),
                      //       "company_id": company_id.toString()
                      //     };

                      //     var response = await http.post(
                      //       Uri.parse(
                      //           'http://invoice.kingzquest.com/api/api.php'),
                      //       headers: <String, String>{
                      //         'Content-Type':
                      //             'application/x-www-form-urlencoded',
                      //       },
                      //       body: queryParameters,
                      //     );
                      //     var result_data = jsonDecode(response.body);

                      //     print("|api");
                      //     _startingTabCount =
                      //         result_data['category_list_count'];
                      //     // print(result_data['category_list_count']);
                      //     // print(result_data['category_list']);
                      //     category_list = result_data['category_list'];

                      //     products_list = result_data['product_list'];

                      //     // print(result_data);

                      //     Navigator.push(
                      //       context,
                      //       // MaterialPageRoute(builder: (context) => Additems()),
                      //       MaterialPageRoute(
                      //           builder: (context) => Productgridk(
                      //                 startingTabCountapp: _startingTabCount,
                      //                 category_listapp: category_list,
                      //                 products_listapp: products_list,
                      //               )),
                      //     ).then((_) {
                      //       setState(() {
                      //         // Call setState to refresh the page.
                      //         // save_pref_product();
                      //         _initCheck();
                      //       });
                      //       // This block runs when you have returned back to the 1st Page from 2nd.
                      //     });
                      //   },
                      //   child: Text('Add Items new'),
                      // ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // FastAutocomplete<String>(
                  //   name: 'autocomplete',
                  //   labelText: 'Autocomplete',
                  //   options: const [
                  //     'Alaska',
                  //     'Alabama',
                  //     'Connecticut',
                  //     'Delaware'
                  //   ],
                  // ),

                  SingleChildScrollView(
                    child: Container(
                      child: _buildPanel(),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('Processing Data')),
                  //       );
                  //       print(formvalues);
                  //       var finalvalue = jsonEncode(formvalues);
                  //       await masterlogin(finalvalue).then((val) {
                  //         print(val);
                  //       });
                  //     }
                  //   },
                  //   child: const Text('Submit'),
                  // ),
                ],
              ),
              // ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // print(itemslistarray);
          if (customername != '' && itemslistarray.length > 0) {
            var arr = [];

            itemslistarray.forEach((item) {
              // print(item["headertotal"]);
              //getting the key direectly from the name of the key
              var obj = {
                'productquantity': item['headerquentity'],
                'itemprice': item['headerprice'],
                'itemtax': item['headertax'],
                'selecteditem': item['headerid'],
                'itemdiscount': 0,
                'itemcode': item['headercode'],
              };
              arr.add(obj);
            });

            //             selecteditem

            //             [{headerValue: ice, headerprice: 12, headercode: YUUJ887, headerquentity: 60, headertotal: 720, grandtotal: 720}]
            // productquantity >> headerquentity
            // itemprice > headerprice
            // itemtax > 0
            // itemdiscount >> >> 0
            // itemcode >> headercode

            var obj = {};

            obj['items'] = jsonEncode(arr);
            obj['loginrole'] = loginrole;
            var master_id = '';
            var company_id = '';
            if (loginrole == 2) {
              var master_id = loginuserid;
            }
            if (loginrole == 3) {
              var company_id = loginuserid;
            }
            obj['company_id'] = company_id;
            obj['master_id'] = master_id;
            obj['company_contact'] = billing_name + '/n' + billing_address;
            obj['client'] = 0;
            obj['clientselected'] =
                customername + '/n' + customeraddress + '/n/' + customerphone;
            obj['subTotal'] = overalltotal;
            obj['discountTotal'] = 0;
            obj['taxTotal'] = 0;
            obj['grandTotal'] = overalltotal;
            obj['invoicenumber'] = '${DateTime.now().year}-999999';
            obj['taxRate'] = 0;
            obj['discountRate'] = 0;

            formvalues.add(obj);

            var finalvalue = jsonEncode(formvalues);
            await puchaselogin(finalvalue).then((val) {
              // print(val);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('Added Sucessfully')),
              // );
            });

            createprint();

            // generatemyPdf();
          }
        },
        icon: const Icon(Icons.print),
        label: const Text('Save & print'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Save & print',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Print',
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.school),
      //     //   label: 'School',
      //     // ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: (value) async {
      //     if (value == 0) {}
      //     if (customername != '' && itemslistarray.length > 0) {
      //       createprint();
      //       // generatemyPdf();
      //     }
      //   },
      // ),
    );
  }

  Widget _buildPanel() {
    int stock = 0;
    List<TextEditingController> controllers = [];

    if (storage.getItem("store_product_list") != null) {
      //  alert('yes');
      // print("localsdtoreaaaaa");
      var product = storage.getItem('store_product_list');

      itemslistarray = product;
      // setState(() {
      //   // itemslistarray = product;
      //   itemslistarray[0]['headerquentity'] = product[0]['headerquentity'];
      //   itemslistarray[1]['headertotal'] = product[0]['headertotal'].toString();
      // });
      print(itemslistarray);
    }

    // print("_buildPanel");
    // print(itemslistarray);
    // int lenff = 2;
    // for (int i = 1; i < lenff; i++) {
    //   print(
    //       controllers[i].text); //printing the values to show that it's working
    // }
    // var _total = '0';
    // print("inn");
    // if (itemslistarray.length != 0) {
    //   print("inn");
    //   // var _total = itemslistarray
    //   //     .map<double>((p) => p.headertotal)
    //   //     .reduce((a, b) => a + b);
    // }

    // setState(() {
    //   overalltotal = _total.toString();
    // });

    //  var data = [{"Title": "product 1", "Item Score": 87.3, "Characters": 72, "Image Count": 6}, {"Title": "product 2", "Item Score": 85.1, "Characters": 56, "Image Count": 2}];

    double totalScores = 0.0;
    // looping over data array
    itemslistarray.forEach((item) {
      // print(item["headertotal"]);
      //getting the key direectly from the name of the key
      totalScores += int.parse(item["headertotal"]);
    });

    // var _total = itemslistarray.length != 0
    //     ? itemslistarray
    //         .map<int>((p) => int.parse(p.headertotal))
    //         .reduce((a, b) => a + b)
    //     : '0';

    setState(() {
      overalltotal = totalScores.toString();
    });

    @override
    void dispose() {
      controllers.clear();
      super.dispose();
    }

    reportproductfromlist(index) {
      var remove_index = index;
      var producattg = [];
      producattg = storage.getItem('store_selectedListid_count');
      // producattg..removeAt(index);

      // var producattg = [];
      // producattg = storage.getItem('store_selectedListid_count');

      print(index);
      print(producattg);
      // print("itemslistarray_headerid");
      // print(itemslistarray[index]['headerid']);
      var i = 0;
      producattg.forEach((element) {
        if (itemslistarray[index]['headerid'] == element['product_id']) {
          //     // var selcount = {
          //     //   'product_id': element['product_id'],
          //     //   'product_count': int.parse(
          //     //       itemslistarray[index]['headerquentity'])
          //     // };
          // print("element");
          // print(element);
          // print(i);
          remove_index = i;

          // producattg.remove(element);
          //     // producattg.add(selcount);
        }
        i++;
      });

      producattg..removeAt(remove_index);

      // print(producattg);
      // storage.setItem('store_selectedListid_count', producattg);
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemslistarray.length,
      padding: EdgeInsets.all(0),
      controller: ScrollController(keepScrollOffset: true),
      itemBuilder: (context, index) {
        // var cal = int.parse(itemslistarray[index]['headertotal']) +
        //     int.parse(overalltotal);
        // overalltotal = cal.toString();
        // if (itemslistarray.length == index) {
        //   setState(() {
        //     overalltotal = cal.toString();
        //   });
        // }

        // print("Item>>>>>");
        // print(itemslistarray[index]);
        // print("Item>>>>>");
        // print(index);
        // var arrayval = {"Qty " + itemslistarray[index]['headerquentity']};

        // setState(() {
        //   qty.add(arrayval);
        // });

        TextEditingController controller = TextEditingController(
            text: itemslistarray[index]['headerquentity']);
        controllers.add(controller);
        // TextEditingController controller =
        //     TextEditingController(text: '$stock');
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 243, 243),
              border: Border.all(color: Color.fromARGB(255, 23, 23, 24)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: <Widget>[
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemslistarray[index]['headerValue'],
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                    Text(
                      "\₹" + itemslistarray[index]['headerprice'],
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 235, 65, 116)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              color: Color.fromARGB(255, 24, 221, 221)),
                          child: Text("-")),
                      onTap: () {
                        int currentValue = int.tryParse(controller.text) ?? 1;
                        controller.text = itemslistarray[index]
                                ['headerquentity'] =
                            (currentValue > 0)
                                ? "${currentValue - 1}"
                                : itemslistarray[index]['headerquentity'];
                        var pvalu = itemslistarray[index]['headerprice'];
                        var totalprice =
                            int.parse(controller.text) * int.parse(pvalu);

                        // int.tryParse(pvalu);
                        setState(() {
                          itemslistarray[index]['headerquentity'] =
                              controller.text;
                          itemslistarray[index]['headertotal'] =
                              totalprice.toString();
                        });

                        double totalScores = 0.0;
                        // looping over data array
                        itemslistarray.forEach((item) {
                          // print(item["headertotal"]);
                          //getting the key direectly from the name of the key
                          totalScores += int.parse(item["headertotal"]);
                        });
                        setState(() {
                          overalltotal = totalScores.toString();
                        });

                        storage.setItem('store_product_list', itemslistarray);

                        var producattg = [];
                        producattg =
                            storage.getItem('store_selectedListid_count');

                        producattg.forEach((element) {
                          if (itemslistarray[index]['headerid'] ==
                              element['product_id']) {
                            var selcount = {
                              'product_id': element['product_id'],
                              'product_count': int.parse(
                                  itemslistarray[index]['headerquentity'])
                            };

                            producattg.remove(element);
                            producattg.add(selcount);
                          }

                          // print("element");
                          // print(element);
                          // print(itemslistarray[index]['headerid']);
                        });
                        // storage.setItem(
                        //     'store_selectedListid_count', producattg);
                        // print("producattg");
                        // print(producattg);
                        // producattg..removeAt(index);
                        // var selcount = {
                        //   'product_id': itemslistarray[index]['headerid'],
                        //   'product_count':
                        //       int.parse(itemslistarray[index]['headerquentity'])
                        // };
                        // producattg.add(selcount);
                        // print("store_selectedListid_count");
                        // print(storage.getItem('store_selectedListid_count'));
                        // var grandtotal = itemslistarray
                        //     .map<double>((p) => p.headertotal)
                        //     .reduce((a, b) => a + b);
                        // setState(() {
                        //   overalltotal = grandtotal.toString();
                        // });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      width: 55,
                      child: TextField(
                        controller: controller,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: itemslistarray[index]['headerquentity'],
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              color: Color.fromARGB(255, 233, 212, 23)),
                          child: Text("+")),
                      onTap: () {
                        int currentValue = int.tryParse(controller.text) ??
                            itemslistarray[index]['headerquentity'];
                        controller.text = itemslistarray[index]
                            ['headerquentity'] = "${currentValue + 1}";
                        var pvalu = itemslistarray[index]['headerprice'];
                        var totalprice =
                            int.parse(controller.text) * int.parse(pvalu);

                        setState(() {
                          itemslistarray[index]['headertotal'] =
                              totalprice.toString();
                          itemslistarray[index]['headerquentity'] =
                              controller.text;
                        });
                        double totalScores = 0.0;
                        // looping over data array
                        itemslistarray.forEach((item) {
                          // print(item["headertotal"]);
                          //getting the key direectly from the name of the key
                          totalScores += int.parse(item["headertotal"]);
                        });
                        setState(() {
                          overalltotal = totalScores.toString();
                        });

                        storage.setItem('store_product_list', itemslistarray);

                        var producattg = [];
                        producattg =
                            storage.getItem('store_selectedListid_count');

                        producattg.forEach((element) {
                          if (itemslistarray[index]['headerid'] ==
                              element['product_id']) {
                            var selcount = {
                              'product_id': element['product_id'],
                              'product_count': int.parse(
                                  itemslistarray[index]['headerquentity'])
                            };

                            producattg.remove(element);
                            producattg.add(selcount);
                          }
                        });
                        // var producattg = [];
                        // producattg =
                        //     storage.getItem('store_selectedListid_count');
                        // print("producattg");
                        // print(producattg);
                        // producattg..removeAt(index);
                        // var selcount = {
                        //   'product_id': itemslistarray[index]['headerid'],
                        //   'product_count':
                        //       int.parse(itemslistarray[index]['headerquentity'])
                        // };
                        // producattg.add(selcount);
                        // var grandtotal = itemslistarray
                        //     .map<double>((p) => p.headertotal)
                        //     .reduce((a, b) => a + b);
                        // setState(() {
                        //   overalltotal = grandtotal.toString();
                        // });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "\₹" + itemslistarray[index]['headertotal'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 40, 128, 5)),
                  ),
                  Text(
                    "Qty " + itemslistarray[index]['headerquentity'],
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 226, 163, 25)),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),

              InkWell(
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 25, 26, 27),
                ),
                onTap: () {
                  setState(() {
                    reportproductfromlist(index);
                    itemslistarray..removeAt(index);
                    storage.setItem('store_product_list', itemslistarray);

                    // var producat = storage.getItem('store_selectedListid_count');
                    // itemslistarray.removeWhere((index) =>
                    //     itemslistarray[index]['headertotal'] ==
                    //     itemslistarray[index]['headertotal']);
                    // itemslistarray[index]['headertotal']
                    // itemslistarray.removeWhere(
                    //     (itemslistarray) => index == itemslistarray[index]);
                    // _data.removeWhere((Item currentItem) => item == currentItem);
                  });
                  double totalScores = 0.0;
                  // looping over data array
                  itemslistarray.forEach((item) {
                    // print(item["headertotal"]);
                    //getting the key direectly from the name of the key
                    totalScores += int.parse(item["headertotal"]);
                  });
                  setState(() {
                    overalltotal = totalScores.toString();
                  });
                },
              ),
              // ElevatedButton(

              //   onPressed: () {
              //     print("Container clicked");
              //   },
              //   // style: ButtonStyle(
              //   //     padding: MaterialStateProperty.all<EdgeInsets>(
              //   //         EdgeInsets.all(8)),
              //   //     foregroundColor:
              //   //         MaterialStateProperty.all<Color>(Colors.red),
              //   //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //   //         RoundedRectangleBorder(
              //   //             borderRadius: BorderRadius.circular(22.0),
              //   //             side: BorderSide(color: Colors.red)))),
              //   child: Icon(
              //     Icons.delete,
              //     color: Color.fromARGB(255, 25, 26, 27),
              //   ),

              //   // padding: EdgeInsets.all(3),
              // ),
            ],
          ),
        );
      },
    );
    // print("_dataaaaaaaaaaaaaa");
    // return ExpansionPanelList(
    //   expansionCallback: (int index, bool isExpanded) {
    //     setState(() {
    //       _data[index].isExpanded = !isExpanded;
    //     });
    //   },
    //   children: _data.map<ExpansionPanel>((Item item) {
    //     TextEditingController controller =
    //         TextEditingController(text: '$stock');
    //     controllers.add(controller);
    //     // TextEditingController controller =
    //     //     TextEditingController(text: '$stock');
    //     print(item);
    //     print("itemaaa");
    //     return ExpansionPanel(
    //       headerBuilder: (BuildContext context, bool isExpanded) {

    //         // return ListTile(
    //         //   title: Text(item.headerValue),
    //         //   trailing: new Container(
    //         //     width: 150.0,
    //         //     child: new Row(
    //         //       crossAxisAlignment: CrossAxisAlignment.center,
    //         //       children: [
    //         //         GestureDetector(
    //         //           child: Container(
    //         //               padding: EdgeInsets.all(8),
    //         //               decoration: ShapeDecoration(
    //         //                   shape: CircleBorder(), color: Colors.cyanAccent),
    //         //               child: Text("-")),
    //         //           onTap: () {
    //         //             int currentValue = int.tryParse(controller.text) ?? 1;
    //         //             controller.text = (currentValue > 0)
    //         //                 ? "${currentValue - 1}"
    //         //                 : item.headerquentity;
    //         //           },
    //         //         ),
    //         //         Container(
    //         //           padding: EdgeInsets.symmetric(horizontal: 12),
    //         //           width: 40,
    //         //           child: TextField(
    //         //             controller: controller,
    //         //             maxLength: 3,
    //         //             textAlign: TextAlign.center,
    //         //             decoration: InputDecoration(
    //         //               hintText: "0",
    //         //               border: InputBorder.none,
    //         //               counterText: "",
    //         //             ),
    //         //             keyboardType: TextInputType.number,
    //         //           ),
    //         //         ),
    //         //         InkWell(
    //         //           customBorder: CircleBorder(),
    //         //           child: Padding(
    //         //             padding: const EdgeInsets.all(8.0),
    //         //             child: Text("+"),
    //         //           ),
    //         //           onTap: () {
    //         //             int currentValue = int.tryParse(controller.text) ?? 1;
    //         //             controller.text = "${currentValue + 1}";
    //         //           },
    //         //         ),
    //         //       ],
    //         //     ),
    //         //   ),
    //         // );
    //       },
    //       body: ListTile(
    //           title: Text(item.expandedValue),
    //           // subtitle:
    //           //     const Text('To delete this panel, tap the trash can icon'),
    //           trailing: const Icon(Icons.delete),
    //           onTap: () {
    //             setState(() {
    //               _data.removeWhere((Item currentItem) => item == currentItem);
    //             });
    //           }),
    //       isExpanded: item.isExpanded,
    //     );
    //   }).toList(),
    // );
  }
}

// String loginuserid = '';
// String loginrole = '';

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginuserid = prefs.getString('user_id').toString();
    loginrole = prefs.getString('role').toString();
    var master_id = '0';
    var company_id = '0';
    if (loginrole == 2) {
      master_id = loginuserid;
    }
    if (loginrole == 3) {
      company_id = loginuserid;
    }
    final response = await http.post(
      Uri.parse('https://kingzquest.com/invoice/api/api.php'),
      body: {
        "page": '1',
        "size": '-1',
        // "limit": paginate.limit,
        "report_action": "customerlist",
        // "report_action": "customerlistapp",
        "master_id": master_id,
        "loginrole": loginrole,
        "company_id": company_id,
        "search": query
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];

    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;

    var albums = jsonDecode(data);
    albums = albums['user_list'];
    // var limit = albums['totalcount'];
    // print(albums);
    // var users = albums['user_list'];
    // print(albums.length);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString(),
          'address': albums[index]['address'].toString(),
          'phone': albums[index]['phone'].toString()
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

// class usertdata {
//   final String id;
//   final String name;

//   const usertdata({
//     required this.id,
//     required this.name,
//   });

//   factory usertdata.fromJson(Map<String, dynamic> json) {
//     return usertdata(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }

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

class Additems extends StatefulWidget {
  const Additems({Key? key}) : super(key: key);

  @override
  State<Additems> createState() => _AdditemsState();
}

class _AdditemsState extends State<Additems> {
  TextEditingController pricecrl = new TextEditingController(text: '0');

  static const _locale = 'en_IN';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  TextEditingController quentitycrl = new TextEditingController();
  TextEditingController taxcrl = new TextEditingController(text: '0');
  TextEditingController unitcrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List formvalues = [];
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selecteditems;
  String? _selecteditemslist;
  String? _selecteditemslistprince;
  String? _selecteditemslistquentity;
  String? _selecteditemslistcode;
  String? _selecteditemslistid;
  String? _selecteditemslisttotal;

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
                          hintText: 'Select Items'),
                      controller: _typeAheadController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await BackendServiceapi.getSuggestions(pattern);
                    },
                    itemBuilder: (context, Map<String, String> suggestion) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(suggestion['name']!),
                        trailing: Text('\₹${suggestion['price']}'),
                        // subtitle: Text('\$${suggestion['price']}'),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Map<String, String> suggestion) {
                      // print(suggestion['name']);
                      print(suggestion);
                      // pricecrl
                      // quentitycrl
                      // taxcrl
                      // unitcrl
                      var itemid = suggestion['id'].toString();
                      pricecrl.text = suggestion['price'].toString();
                      quentitycrl.text = '1';
                      taxcrl.text = suggestion['tax'].toString();
                      unitcrl.text = 'KG';
                      var total = int.parse(pricecrl.text) *
                          int.parse(quentitycrl.text);
                      setState(() {
                        _selecteditemslistid = itemid;
                        _selecteditemslist = suggestion['name'];
                        _selecteditemslistprince = suggestion['price'];
                        _selecteditemslistcode = suggestion['code'];
                        _selecteditemslistquentity = quentitycrl.text;
                        _selecteditemslisttotal = total.toString();
                      });
                      // var concatenate = StringBuffer();
                      // concatenate.write(suggestion);
                      String selectedname = suggestion['name'].toString();
                      //  List<String> selectedname = suggestion['name'];
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
                    onSaved: (value) => this._selecteditems = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: quentitycrl,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Quantity",
                              fillColor: Colors.white70),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: unitcrl,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Unit",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: pricecrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixText: _currency,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "price",
                              fillColor: Colors.white70),
                          onChanged: (string) {
                            string =
                                '${_formatNumber(string.replaceAll(',', ''))}';
                            pricecrl.value = TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(
                                  offset: string.length),
                            );
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: taxcrl,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], //
                          decoration: InputDecoration(
                              prefixText: '%',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "tax",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              // foregroundColor:
                              //     MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () async {
                            final _SalesLoginState ani = new _SalesLoginState();
                            // @override
                            // Widget build(BuildContext context) {
                            //   return GestureDetector(
                            //     onTap: () => ani._initCheck(),
                            //   );
                            // }

                            final store = await SharedPreferences.getInstance();
                            // print(_selecteditemslist);
                            if (_selecteditemslist != null) {
                              store.setString('itemname', "_selecteditems");
                              store.setBool('itemnamea', true);
                              store.setBool('itemnameb', true);
                              // Navigator.of(context).pop();
                              // Item obg = Item(
                              //   headerValue: 'myvalue karthii item',
                              //   expandedValue: 'This is item numberPanel sssss',
                              // );
                              var total = int.parse(pricecrl.text) *
                                  int.parse(quentitycrl.text);

                              var grandtotal = total;

                              // if (itemslistarray.length != 0) {
                              //   var grandtotal = itemslistarray
                              //       .map<dynamic>(
                              //           (p) => int.parse(p.headertotal))
                              //       .reduce((a, b) => a + b);
                              //   // var _grandtotal1 = _grandtotal.toInt();
                              //   // var total1 = total.toInt();
                              //   // _grandtotal =
                              //   //     int.parse(_grandtotal1) + int.parse(total1);
                              // }
                              // var _grandtotal = itemslistarray.length != 0
                              //     ? itemslistarray
                              //         .map<double>((p) => p.headertotal)
                              //         .reduce((a, b) => a + b)
                              //     : total;

                              var arrayval = {
                                'headerValue': _selecteditemslist,
                                'headerprice': _selecteditemslistprince,
                                'headercode': _selecteditemslistcode,
                                'headerquentity': quentitycrl.text,
                                'headertax': taxcrl.text,
                                'headerid': _selecteditemslistid,
                                'headertotal': total.toString(),
                                'grandtotal': grandtotal.toString(),
                              };
                              setState(() {
                                // user = prefs.getBool('user');
                                _selectedItems = _selectedItems + 1;
                                itemslistarray.add(arrayval);
                              });

                              double totalScores = 0.0;
                              // looping over data array
                              itemslistarray.forEach((item) {
                                // print(item["headertotal"]);
                                //getting the key direectly from the name of the key
                                totalScores += int.parse(item["headertotal"]);
                              });
                              setState(() {
                                overalltotal = totalScores.toString();
                              });
                              // print(">>>>>>>");
                              // print(itemslistarray);
                              // print(">>>>>>>");
                              // Item obg = Item(
                              //   headerValue: 'Panel sssss',
                              //   expandedValue: 'This is item numberPanel sssss',
                              // );
                              // _data.add(obg);
                              // ani.build;
                              // print("_selectedItems print");
                              // print(_selectedItems);

                              ani._initCheck();
                              // _data = generateItems(20);
                              // print(_data);
                              // Navigator.pop(context);

                              Navigator.pop(context, true);
                              // Navigator.pop()
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                      // Flexible(
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //             MaterialStateProperty.all<Color>(Colors.red),
                      //         // foregroundColor:
                      //         //     MaterialStateProperty.all<Color>(Colors.red),
                      //         shape: MaterialStateProperty.all<
                      //                 RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(18.0),
                      //                 side: BorderSide(color: Colors.red)))),
                      //     onPressed: () async {
                      //       final _SalesLoginState ani = new _SalesLoginState();
                      //       // @override
                      //       // Widget build(BuildContext context) {
                      //       //   return GestureDetector(
                      //       //     onTap: () => ani._initCheck(),
                      //       //   );
                      //       // }

                      //       final store = await SharedPreferences.getInstance();
                      //       // print(_selecteditemslist);
                      //       if (_selecteditemslist != null) {
                      //         store.setString('itemname', "_selecteditems");
                      //         store.setBool('itemnamea', true);
                      //         store.setBool('itemnameb', true);
                      //         // Navigator.of(context).pop();
                      //         // Item obg = Item(
                      //         //   headerValue: 'myvalue karthii item',
                      //         //   expandedValue: 'This is item numberPanel sssss',
                      //         // );
                      //         var total = int.parse(pricecrl.text) *
                      //             int.parse(quentitycrl.text);
                      //         var arrayval = {
                      //           'headerValue': _selecteditemslist,
                      //           'headerprice': _selecteditemslistprince,
                      //           'headercode': _selecteditemslistcode,
                      //           'headerquentity': quentitycrl.text,
                      //           'headertotal': total.toString(),
                      //         };

                      //         setState(() {
                      //           // user = prefs.getBool('user');
                      //           _selectedItems = _selectedItems + 1;
                      //           itemslistarray.add(arrayval);
                      //         });
                      //         generateItems(itemslistarray.length);
                      //         double totalScores = 0.0;
                      //         // looping over data array
                      //         itemslistarray.forEach((item) {
                      //           // print(item["headertotal"]);
                      //           //getting the key direectly from the name of the key
                      //           totalScores += int.parse(item["headertotal"]);
                      //         });
                      //         setState(() {
                      //           overalltotal = totalScores.toString();
                      //         });
                      //         // print(">>>>>>>");
                      //         // print(itemslistarray);
                      //         // print(">>>>>>>");
                      //         // Item obg = Item(
                      //         //   headerValue: 'Panel sssss',
                      //         //   expandedValue: 'This is item numberPanel sssss',
                      //         // );
                      //         // _data.add(obg);
                      //         // ani.build;
                      //         // print("_selectedItems print");
                      //         // print(_selectedItems);

                      //         ani._initCheck();
                      //         // _data = generateItems(20);
                      //         // print(_data);
                      //         // Navigator.pop(context);
                      //         // Navigator.pushNamed(context, "Additems");
                      //         // Navigator.pushReplacement(
                      //         //   context,
                      //         //   MaterialPageRoute(
                      //         //       builder: (context) =>
                      //         //           Additems()), // this mymainpage is your page to refresh
                      //         //   // (Route<dynamic> route) => false,
                      //         // );
                      //         // Navigator.pop(context, true);
                      //         // Navigator.pushReplacement(
                      //         //   context,
                      //         //   MaterialPageRoute(
                      //         //     builder: (context) => Additems(),
                      //         //   ),
                      //         // );
                      //         // Navigator.pop(context, true);

                      //         // Navigator.of(context).pop();
                      //         // await Future.delayed(Duration(milliseconds: 500));
                      //         // Navigator.of(context).push(MaterialPageRoute(
                      //         //     builder: (context) => Additems()));

                      //         // Navigator.pushReplacement(
                      //         //     context,
                      //         //     MaterialPageRoute(
                      //         //         builder: (BuildContext context) =>
                      //         //             super.widget));
                      //       }
                      //     },
                      //     child: const Text('Add & Continue'),
                      //   ),
                      // ),
                    ],
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginuserid = prefs.getString('user_id').toString();
    loginrole = prefs.getString('role').toString();
    final response = await http.post(
      Uri.parse('http://bill.cablevasool.com/api/api.php'),
      body: {
        'name': query,
        'report_action': 'itemslistapp',
        'master_id': loginuserid,
        'loginrole': loginrole,
      },
    );

    // if (response.statusCode == 200) {
    // List<dynamic> albums = [];
    // print(response);
    //  List<dynamic> albumsJson = jsonDecode(response.body);
    String data = response.body;

    var albums = jsonDecode(data);

    // var limit = albums['totalcount'];
    // print(albums);
    // var users = albums['user_list'];
    // print(albums.length);

    if (albums.length > 0) {
      return List.generate(albums.length, (index) {
        return {
          'name': albums[index]['name'].toString(),
          'id': albums[index]['id'].toString(),
          'price': albums[index]['sale_price'].toString(),
          'tax': albums[index]['tax'].toString(),
          'code': albums[index]['code'].toString()
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

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

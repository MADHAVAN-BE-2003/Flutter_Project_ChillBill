import 'package:flutter_application_1/common/apimodal.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:io';

Future<List> login(username, password) async {
  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'username': username,
      'key': password,
      'report_action': 'userlogin',
    },
  );

  if (response.statusCode == 200) {
    // String data = response.body;
    // var data = [];
    // List<Map<String, dynamic>> send=[] ;
    var usersdata = jsonDecode(response.body);
    var send = [usersdata];
    return send;
    // return logindata.fromJson(jsonDecode(response.body));
    // throw Exception('Failed to load login');
  } else {
    throw Exception('Failed to load login');
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// Future<http.Response> login(username, password) async {
//   return http.post(
//     Uri.parse('https://kingzquest.com/invoice/api/api.php'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: <String, String>{'username': username, 'key': password},
//   );
// }

// Future<logindata> masterlogin(
//     name,
//     email,
//     address,
//     phonenumber,
//     distric,
//     state,
//     username,
//     password,
//     refferd,
//     fee_amount,
//     Payment_type,
//     date_range_picker,
//     num_companies,
//     paid,
//     status,
//     description)
Future<logindata> masterlogin(formvalues) async {
  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'master_login',
      'formvalues': formvalues,
      'formsubmit': 'master_login',
    },
    // body: {
    //   'name': name,
    //   'email': email,
    //   'address': address,
    //   'phonenumber': phonenumber,
    //   'distric': distric,
    //   'state': state,
    //   'username': username,
    //   'password': password,
    //   'refferd': refferd,
    //   'fee_amount': fee_amount,
    //   'Payment_type': Payment_type,
    //   'date_range_picker': date_range_picker,
    //   'num_companies': num_companies,
    //   'paid': paid,
    //   'status': status,
    //   'description': description,
    //   'report_action': 'master_login',
    //   'formsubmit': 'master_login',
    // },
  );
  // print("okay");
  // print(response.body);
  if (response.statusCode == 200) {
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return logindata.fromJson(jsonDecode(response.body));
    // return response.body;
    // throw Exception('Failed to load login');
  } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load login');
  }
}

String loginuserid = '';
Future<logindata> Companylogin(formvalues, master_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'company_login',
      'master': loginuserid,
      'formvalues': formvalues,
      'formsubmit': 'company_login',
      // ignore: equal_keys_in_map
      'master': master_id
    },
    // body: {
    //   'name': name,
    //   'email': email,
    //   'address': address,
    //   'phonenumber': phonenumber,
    //   'distric': distric,
    //   'state': state,
    //   'username': username,
    //   'password': password,
    //   'refferd': refferd,
    //   'fee_amount': fee_amount,
    //   'Payment_type': Payment_type,
    //   'date_range_picker': date_range_picker,
    //   'num_companies': num_companies,
    //   'paid': paid,
    //   'status': status,
    //   'description': description,
    //   'report_action': 'master_login',
    //   'formsubmit': 'master_login',
    // },
  );
  // print("okay");
  // print(response.body);
  if (response.statusCode == 200) {
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return logindata.fromJson(jsonDecode(response.body));
    // return response.body;
    // throw Exception('Failed to load login');
  } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load login');
  }
}

Future<logindata> Userlogin(formvalues, companyid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'usercreatelogin',
      'master': loginuserid,
      'formvalues': formvalues,
      'formsubmit': 'usercreatelogin',
      'company': companyid,
    },
    // body: {
    //   'name': name,
    //   'email': email,
    //   'address': address,
    //   'phonenumber': phonenumber,
    //   'distric': distric,
    //   'state': state,
    //   'username': username,
    //   'password': password,
    //   'refferd': refferd,
    //   'fee_amount': fee_amount,
    //   'Payment_type': Payment_type,
    //   'date_range_picker': date_range_picker,
    //   'num_companies': num_companies,
    //   'paid': paid,
    //   'status': status,
    //   'description': description,
    //   'report_action': 'master_login',
    //   'formsubmit': 'master_login',
    // },
  );
  // print("okay");
  // print(response.body);
  if (response.statusCode == 200) {
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return logindata.fromJson(jsonDecode(response.body));
    // return response.body;
    // throw Exception('Failed to load login');
  } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load login');
  }
}

String loginrole = '';
Future<logindata> itemcreation(formvalues, image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();

  var request = http.MultipartRequest(
      'POST', Uri.parse('https://kingzquest.com/invoice/api/api.php'));
  request.fields['report_action'] = 'item_create';
  request.fields['master'] = loginuserid;
  request.fields['role'] = loginrole;
  request.fields['formvalues'] = formvalues;
  request.fields['formsubmit'] = 'itemcreate';
  request.files.add(http.MultipartFile.fromBytes(
      'picture', File(image!.path).readAsBytesSync(),
      filename: image!.path));
  // final response = await request.send();
  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'item_create',
      'master': loginuserid,
      'role': loginrole,
      'formvalues': formvalues,
      'formsubmit': 'itemcreate',
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
    // throw Exception('Failed to load login');
  } else {
    throw Exception('Failed to load login');
  }
}

class POST {}

Future<logindata> vendorcreation(formvalues) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'create_vendor',
      'master': loginuserid,
      'role': loginrole,
      'formvalues': formvalues,
      'formsubmit': 'create_customer',
    },
  );

  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load login');
  }
}

Future<logindata> customercreation(formvalues) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'create_customer',
      'master': loginuserid,
      'role': loginrole,
      'formvalues': formvalues,
      'formsubmit': 'create_customer',
    },
  );

  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load login');
  }
}

Future<logindata> expensescreation(
    name, price, description, category_id) async {
  // print(name);
  // print(price);
  // print(description);
  // print(category_id);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();
  print("object");
  var company_id = '';
  var master_id = '';
  if (loginrole == '2') {
    master_id = loginuserid;
  }
  if (loginrole == '3') {
    company_id = loginuserid;
  }

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'expenses_creation',
      'master': loginuserid,
      'role': loginrole,
      // 'formvalues': formvalues,
      // 'formsubmit': 'expenses_creation',
      'master_id': master_id,
      'company_id': company_id,
      'name': name,
      'category': category_id,
      'discription': description,
      'price': price,
      'date': formatted,
    },
  );
  // print(response);
  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load login');
  }
}

Future<logindata> productcategorycreation(name, description) async {
  // print(name);
  // print(price);
  // print(description);
  // print(category_id);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();
  // print("object");
  var company_id = '';
  var master_id = '';
  if (loginrole == '2') {
    master_id = loginuserid;
  }
  if (loginrole == '3') {
    company_id = loginuserid;
  }

  // final DateTime now = DateTime.now();
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  // final String formatted = formatter.format(now);

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'create_item_category',
      'master': loginuserid,
      'role': loginrole,
      // 'formvalues': formvalues,
      // 'formsubmit': 'expenses_creation',
      'master_id': master_id,
      'company_id': company_id,
      'name': name,
      'address': description,
      // 'date': formatted,
    },
  );
  // print(response);
  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load login');
  }
}

Future<logindata> categorycreation(name, description) async {
  // print(name);
  // print(price);
  // print(description);
  // print(category_id);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  loginuserid = prefs.getString('user_id').toString();
  loginrole = prefs.getString('role').toString();
  // print("object");
  var company_id = '';
  var master_id = '';
  if (loginrole == '2') {
    master_id = loginuserid;
  }
  if (loginrole == '3') {
    company_id = loginuserid;
  }

  // final DateTime now = DateTime.now();
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  // final String formatted = formatter.format(now);

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'create_category',
      'master': loginuserid,
      'role': loginrole,
      // 'formvalues': formvalues,
      // 'formsubmit': 'expenses_creation',
      'master_id': master_id,
      'company_id': company_id,
      'name': name,
      'address': description,
      // 'date': formatted,
    },
  );
  // print(response);
  if (response.statusCode == 200) {
    return logindata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load login');
  }
}

Future<logindata> saleslogin(formvalues) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('send');
  loginuserid = prefs.getString('user_id').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'save_sales_invoice',
      'master': loginuserid,
      'formvalues': formvalues,
      'formsubmit': 'save_sales_invoice',
    },
  );
  // print("okay");
  print(response.body);
  if (response.statusCode == 200) {
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return logindata.fromJson(jsonDecode(response.body));
    // return response.body;
    // throw Exception('Failed to load login');
  } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load login');
  }
}

Future<logindata> puchaselogin(formvalues) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('send');
  loginuserid = prefs.getString('user_id').toString();

  final response = await http.post(
    Uri.parse('https://kingzquest.com/invoice/api/api.php'),
    body: {
      'report_action': 'save_purchases_invoice',
      'master': loginuserid,
      'formvalues': formvalues,
      'formsubmit': 'save_purchases_invoice',
    },
  );
  // print("okay");
  print(response.body);
  if (response.statusCode == 200) {
    // print("okayyy");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return logindata.fromJson(jsonDecode(response.body));
    // return response.body;
    // throw Exception('Failed to load login');
  } else {
    // print("noooo");
    // print(response);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load login');
  }
}

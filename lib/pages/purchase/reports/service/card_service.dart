import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/purchase/reports/model/card_model.dart';
import 'package:flutter_application_1/pages/purchase/reports/service/card_service_interface.dart';
import 'package:flutter_application_1/pages/purchase/reports/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CardService extends CardServiceInterface {
  String loginuserid = '';
  String loginrole = '';
  String salesinvoicesearch = '';
  String search = '';
  String fromdate = '';
  String todate = '';
  String statusitemssel = '';
  String totalamount = '';

  late Dio _dio;
  CardService() {
    _dio = Dio();
  }

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    loginuserid = prefs.getString('user_id').toString();
    salesinvoicesearch = prefs.getString('salesinvoicesearch').toString();
    search = prefs.getString('search').toString();
    fromdate = prefs.getString('fromdate').toString();
    todate = prefs.getString('todate').toString();
    statusitemssel = prefs.getString('statusitemssel').toString();
    statusitemssel = statusitemssel == 'All' ? '' : statusitemssel;

    var master_id = '';
    var company_id = '';
    if (loginrole == '2') {
      master_id = loginuserid;
    }
    if (loginrole == '3') {
      company_id = loginuserid;
    }

    var queryParameters = {};
    if (loginrole == '4') {
      company_id = prefs.getString('company_id').toString();
      master_id = prefs.getString('master_id').toString();

      queryParameters = {
        "page": paginate.page.toString(),
        "limit": paginate.limit.toString(),
        "report_action": "purchases_invoice_list",
        "size": paginate.limit.toString(),
        "sortBy": '',
        "sortDesc": 'false',
        "master_id": master_id.toString(),
        "search": salesinvoicesearch.toString(),
        "company_id": company_id.toString(),
        // ignore: equal_keys_in_map
        "search": search.toString(),
        "fromdate": fromdate.toString(),
        "todate": todate.toString(),
        "statusitemssel": statusitemssel.toString()
      };
    } else {
      queryParameters = {
        "page": paginate.page.toString(),
        "limit": paginate.limit.toString(),
        "report_action": "purchases_invoice_list",
        "size": paginate.limit.toString(),
        "sortBy": '',
        "sortDesc": 'false',
        "master_id": master_id.toString(),
        "search": salesinvoicesearch.toString(),
        "company_id": company_id.toString(),
        "loginrole": loginrole.toString(),
        // ignore: equal_keys_in_map
        "search": search.toString(),
        "fromdate": fromdate.toString(),
        "todate": todate.toString(),
        "statusitemssel": statusitemssel.toString()
      };
    }

    // var formData = FormData.fromMap({
    //   "page": paginate.page,
    //   "limit": paginate.limit,
    //   "report_action": "sales_invoice_list",
    //   "size": paginate.limit,
    //   "sortBy": '',
    //   "sortDesc": false,
    //   "master_id": master_id,
    //   "search": salesinvoicesearch,
    //   "company_id": company_id
    // });

    // print(queryParameters);
    try {
      var response = await http.post(
        Uri.parse('http://invoice.kingzquest.com/api/api.php'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: queryParameters,
      );
      var result_data = jsonDecode(response.body);
      final store = await SharedPreferences.getInstance();
      store.setString('totalamount', result_data['totalamount']);
      store.setString('totalinvoice', result_data['totalinvoice']);
      store.setString('totalpending', result_data['totalpending']);
      store.setString('totalreceived', result_data['totalreceived']);
      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      // var response = await _dio
      //     .post('https://kingzquest.com/invoice/api/api.php', data: formData);
      // // print(response.data);
      // var result_data = response.data;
      // var result_data1 = response.data;

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // totalamount = prefs.getString('totalamount').toString();

      print(result_data['totalamount']);
      return result_data['user_list']
          .map((e) => CardModel.fromJson(e))
          .toList()
          .cast<CardModel>() as List<CardModel>;
    } catch (e) {
      return [];
    }
  }
}

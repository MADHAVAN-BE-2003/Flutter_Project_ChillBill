// ignore_for_file: unused_field, unused_local_variable

import 'package:dio/dio.dart';
import 'package:chill_bill/pages/company/list/model/card_model.dart';
import 'package:chill_bill/pages/company/list/service/card_service_interface.dart';
import 'package:chill_bill/pages/company/list/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CardService extends CardServiceInterface {
  late Dio _dio;
  CardService() {
    _dio = Dio();
  }

  String loginuserid = '';
  String loginrole = '';
  String companysearch = '';

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    var companysearch1 = prefs.getString('companysearch').toString();

    if (companysearch1.length != 0) {
      companysearch = companysearch1;
    }

    if (loginrole != '1') {
      loginuserid = prefs.getString('user_id').toString();
    }

    var queryParameters = {
      "page": paginate.page.toString(),
      "size": paginate.limit.toString(),
      "report_action": "companyloginlist",
      "master_id": loginuserid.toString(),
      "search": companysearch.toString(),
      "datesearch": '',
      "sortDesc": 'false',
    };

    var paranm = jsonEncode(<String, String>{
      "page": paginate.page.toString(),
      "size": paginate.limit.toString(),
      "report_action": "companyloginlist",
      "master_id": loginuserid,
      "search": companysearch,
      "datesearch": '',
      "sortDesc": false.toString(),
    });
    var formData = FormData.fromMap({
      "page": paginate.page,
      "size": paginate.limit,
      "report_action": "companyloginlist",
      "master_id": loginuserid,
      "search": companysearch,
      "datesearch": '',
      "sortDesc": false,
    });

    // print(paginate.limit);

    try {
      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      // print(queryParameters);
      // print("company_receive");
      var response = await http.post(
        Uri.parse('http://invoice.kingzquest.com/api/api.php'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: queryParameters,
      );
      // var response = await _dio
      //     .post('http://invoice.kingzquest.com/api/api.php', data: formData);
      // print(response.body);
      // print("company");
      var result_data = jsonDecode(response.body);
      // print(result_data);
      // var result_data = response.data;

      // print(result_data1['user_list']);
      return result_data['user_list']
          .map((e) => CardModel.fromJson(e))
          .toList()
          .cast<CardModel>() as List<CardModel>;
    } catch (e) {
      return [];
    }
  }
}

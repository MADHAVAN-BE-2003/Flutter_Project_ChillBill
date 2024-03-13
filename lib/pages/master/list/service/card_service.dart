import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/master/list/model/card_model.dart';
import 'package:flutter_application_1/pages/master/list/service/card_service_interface.dart';
import 'package:flutter_application_1/pages/master/list/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CardService extends CardServiceInterface {
  late Dio _dio;
  CardService() {
    _dio = Dio();
  }
  String mastersearch = '';

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mastersearch1 = prefs.getString('mastersearch').toString();

    if (mastersearch1.length != 0) {
      mastersearch = mastersearch1;
    }

    var queryParameters = {
      "page": paginate.page.toString(),
      "limit": paginate.limit.toString(),
      "size": paginate.limit.toString(),
      "report_action": "masterloginlist",
      "search": mastersearch.toString()
    };

    // print(queryParameters);
    var formData = FormData.fromMap({
      "page": paginate.page,
      "limit": paginate.limit,
      "size": paginate.limit,
      "report_action": "masterloginlist",
      "search": mastersearch
    });

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

      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      // var response = await _dio
      //     .post('http://invoice.kingzquest.com/api/api.php', data: formData);
      // // print(response.data);
      // var result_data = response.data;
      // var result_data1 = response.data;

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

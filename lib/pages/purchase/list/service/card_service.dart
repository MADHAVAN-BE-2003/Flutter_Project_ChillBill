// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:chill_bill/pages/purchase/list/model/card_model.dart';
import 'package:chill_bill/pages/purchase/list/service/card_service_interface.dart';
import 'package:chill_bill/pages/purchase/list/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardService extends CardServiceInterface {
  String loginuserid = '';
  String loginrole = '';
  String salesinvoicesearch = '';

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

    var queryParameters = {
      "page": paginate.page,
      "limit": paginate.limit,
      "report_action": "sales_invoice_list",
      "size": '',
      "sortBy": '',
      "sortDesc": false,
      "master_id": 0,
      "search": '',
      "company_id": 0
    };

    var master_id = '';
    var company_id = '';
    if (loginrole == '2') {
      master_id = loginrole;
    }
    if (loginrole == '3') {
      company_id = loginrole;
    }

    var formData = FormData.fromMap({
      "page": paginate.page,
      "limit": paginate.limit,
      "report_action": "purchases_invoice_list",
      "size": paginate.limit,
      "sortBy": '',
      "sortDesc": false,
      "master_id": master_id,
      "search": salesinvoicesearch,
      "company_id": company_id
    });

    // print(queryParameters);
    try {
      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      var response = await _dio
          .post('https://kingzquest.com/invoice/api/api.php', data: formData);
      // print(response.data);
      var result_data = response.data;
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

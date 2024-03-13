import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/items/list/model/card_model.dart';
import 'package:flutter_application_1/pages/items/list/service/card_service_interface.dart';
import 'package:flutter_application_1/pages/items/list/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardService extends CardServiceInterface {
  late Dio _dio;
  CardService() {
    _dio = Dio();
  }

  String loginuserid = '';
  String loginrole = '';
  String productsearch = '';

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    loginuserid = prefs.getString('user_id').toString();
    productsearch = prefs.getString('productsearch').toString();

    var queryParameters = {
      "page": paginate.page,
      "limit": paginate.limit,
      "report_action": "itemslistingapp",
      "master_id": loginuserid,
      "loginrole": loginrole,
      "search": productsearch
    };
    var formData = FormData.fromMap({
      "page": paginate.page,
      "limit": paginate.limit,
      "report_action": "itemslist",
      "master_id": loginuserid,
      "loginrole": loginrole,
      "search": productsearch
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

import 'package:dio/dio.dart';
import 'package:chill_bill/pages/category/list/model/card_model.dart';
import 'package:chill_bill/pages/category/list/service/card_service_interface.dart';
import 'package:chill_bill/pages/category/list/model/pagination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardService extends CardServiceInterface {
  late Dio _dio;
  CardService() {
    _dio = Dio();
  }

  String loginuserid = '';
  String loginrole = '';
  String customersearch = '';

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    loginuserid = prefs.getString('user_id').toString();
    var master_id = '0';
    var company_id = '0';
    if (loginrole == 2) {
      master_id = loginuserid;
    }
    if (loginrole == 3) {
      company_id = loginuserid;
    }

    customersearch = prefs.getString('customersearch').toString();

    // var queryParameters = {
    //   "page": paginate.page,
    //   "limit": paginate.limit,
    //   "report_action": "companyloginlist",
    // };
    var formData = FormData.fromMap({
      "page": paginate.page,
      "size": paginate.limit,
      "limit": paginate.limit,
      "report_action": "categorylist",
      // "report_action": "customerlistapp",
      "master_id": master_id,
      "loginrole": loginrole,
      "company_id": company_id,
      "search": customersearch
    });

    print(customersearch);
    try {
      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      var response = await _dio
          .post('https://kingzquest.com/invoice/api/api.php', data: formData);
      print(response.data);
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

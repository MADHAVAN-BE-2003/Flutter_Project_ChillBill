import 'package:chill_bill/pages/users/list/model/card_model.dart';
import 'package:chill_bill/pages/users/list/model/pagination_model.dart';
import 'package:chill_bill/pages/users/list/service/card_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardService extends CardServiceInterface {
  late Dio _dio;
  CardService() {
    _dio = Dio();
  }

  String loginuserid = '';
  String loginrole = '';
  String employesearch = '';

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginrole = prefs.getString('role').toString();
    loginuserid = prefs.getString('user_id').toString();
    employesearch = prefs.getString('employesearch').toString();

    var master_id = '0';
    var company_id = '0';
    if (loginrole == 2) {
      master_id = loginuserid;
    }
    if (loginrole == 3) {
      company_id = loginuserid;
    }

    // if (employesearch1.length != 0) {
    //   employesearch = employesearch1;
    // }else{
    //   employesearch = '';
    // }

    var queryParameters = {
      "page": paginate.page,
      "limit": paginate.limit,
      "size": paginate.limit,
      "report_action": "usersloginlist",
      "master_id": master_id,
      "loginrole": loginrole,
      'search': employesearch,
      "company_id": company_id
    };
    var formData = FormData.fromMap({
      "page": paginate.page,
      "limit": paginate.limit,
      "size": paginate.limit,
      "report_action": "usersloginlist",
      "master_id": master_id,
      "loginrole": loginrole,
      'search': employesearch,
      "company_id": company_id
    });

    print(queryParameters);
    try {
      // var response = await _dio.get(
      //     'https://kingzquest.com/invoice/api/api.php?as=karthik',
      //     queryParameters: {'id': 12, 'name': 'wendu'});
      var response = await _dio
          .post('https://kingzquest.com/invoice/api/api.php', data: formData);
      print(response.data);
      print("response.data");
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

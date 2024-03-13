import 'package:flutter_application_1/pages/company/list/service/card_service_interface.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_application_1/pages/company/list/model/card_model.dart';
import 'package:flutter_application_1/pages/company/list/service/card_service.dart';
import 'package:flutter_application_1/pages/company/list/model/pagination_model.dart';

part 'cards_view_model.g.dart';

class CardsViewModel = _CardsViewModel with _$CardsViewModel;

abstract class _CardsViewModel with Store {
  late CardServiceInterface _service;

  bool isFetchData = false;
  int _page = 1;
  int _limit = 5;

  void init() {
    _service = CardService();
  }

  ObservableList<CardModel> cards = ObservableList<CardModel>();

  Future fetchCards() async {
    if (isFetchData) {
      return;
    }

    isFetchData = true;

    print(_page);

    var paginate = PaginationModel(page: _page, limit: _limit);
    var res = await _service.fetchCards(paginate);
    if (res != null && res.isNotEmpty) {
      cards.addAll(res);
      _page++;
    }

    isFetchData = false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/purchase/reports/view/cards_view.dart';

class Purchasereports extends StatefulWidget {
  Purchasereports({Key? key}) : super(key: key);

  @override
  State<Purchasereports> createState() => _PurchasereportsState();
}

class _PurchasereportsState extends State<Purchasereports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Reports'),
      ),
      body: Container(
        child: CardsView(),
      ),
    );
  }
}

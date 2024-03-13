import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/sales/reports/view/cards_view.dart';

class Salesreports extends StatefulWidget {
  Salesreports({Key? key}) : super(key: key);

  @override
  State<Salesreports> createState() => _SalesreportsState();
}

class _SalesreportsState extends State<Salesreports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Reports'),
      ),
      body: Container(
        child: CardsView(),
      ),
    );
  }
}

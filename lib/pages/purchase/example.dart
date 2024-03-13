import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/purchase/saleslogin.dart';
import 'package:flutter_application_1/pages/purchase/list/view/cards_view.dart';

// const examples = <Example>[
//   Example('list', 'cards_view.dart', CardsView),
//   Example('add', 'saleslogin.dart', SalesLogin),
// ];

typedef LayoutCallbackWithData = Future<Uint8List> Function();

class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}

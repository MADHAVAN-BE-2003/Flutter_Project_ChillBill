// ignore_for_file: unused_import, unused_local_variable

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    print("aaaaaa");
    // final bytes = await pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    // await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    print(url);
    final doc = pw.Document(title: 'My Résuméa', author: 'David PHAM-VAN');

    // final fileas = File(file.path);
    // await fileas.writeAsBytes(await doc.save());

    // await Printing.sharePdf(bytes: await doc.save(), filename: url);

    // await OpenFile.open(url);
  }
}

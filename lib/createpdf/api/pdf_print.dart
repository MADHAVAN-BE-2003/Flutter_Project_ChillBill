import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import '../data.dart';

// Future<void> main() async {
//   runApp(const MyApp('Printing Demo'));
// }

// class MyApp extends StatelessWidget {
//   const MyApp(this.title, {Key? key}) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text(title)),
//         body: PdfPreview(
//           build: (format) => _generatePdf(format, title),
//         ),
//       ),
//     );
//   }

Future<Uint8List> generatemyPdf() async {
  // final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final pdf = pw.Document(title: 'My Résuméa', author: 'David PHAM-VAN');
  // final font = await PdfGoogleFonts.nunitoExtraLight();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              width: double.infinity,
              child: pw.FittedBox(
                child: pw.Text('title'),
              ),
            ),
            pw.SizedBox(height: 20),
            // pw.Flexible(child: pw.FlutterLogo())
          ],
        );
      },
    ),
  );
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
  // var as = pdf.save();
  // print(as);

  return pdf.save();
}
// }

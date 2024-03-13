import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/createpdf/page/pdf_page.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   runApp(MyApp());
// }

class MyAppprint extends StatelessWidget {
  static final String title = 'Invoice';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: PdfPage(),
      );
}

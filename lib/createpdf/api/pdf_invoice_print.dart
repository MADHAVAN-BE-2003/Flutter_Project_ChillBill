// import 'dart:io';
import 'package:flutter_application_1/createpdf/api/pdf_api.dart';
import 'package:flutter_application_1/createpdf/model/customer.dart';
import 'package:flutter_application_1/createpdf/model/invoice.dart';
import 'package:flutter_application_1/createpdf/model/supplier.dart';
import 'package:flutter_application_1/createpdf/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// class PdfInvoiceApi {
generatepdfprint(productlist, billing_name, billing_address, customername,
    customeraddress, invoicedata) async {
  // final pdf = Document();

  // pdf.addPage(MultiPage(
  //   build: (context) => [
  //     buildHeader(invoice),
  //     SizedBox(height: 3 * PdfPageFormat.cm),
  //     buildTitle(invoice),
  //     buildInvoice(invoice),
  //     Divider(),
  //     buildTotal(invoice),
  //   ],
  //   footer: (context) => buildFooter(invoice),
  // ));

  // var rng = new Random();
  var invoiceNumber = '${DateTime.now().year}-9999';

  // return PdfApi.saveDocument(name: 'karthikk.pdf', pdf: pdf);
  final lorem = pw.LoremText();
  // print("productlistaaaaa");
  // print(productlist);
  final products = await productlist.map((item) {
    var quantity = int.parse(item['headerquentity']);
    //  int quantity = assert(myInt is int);
    var lat2 = double.parse(item['headerprice']);
    return Product(
        item['headercode'].toString(),
        item['headerValue'].toString(),
        lat2,
        quantity,
        item['headertax'].toString());

    // print(item['headerValue']);
    // print("print_listttt");
    // return "asdasdasd";
  }).toList();
  // print(products);
  // print('productslists');
  // final products = productlist
  //     .map((key, value) => Product('19874', lorem.sentence(6), 3.99, 2))
  //     .toList();

  // final List<Product> products = productlist
  //     .map((entry) => Product('19874', lorem.sentence(6), 3.99, 2))
  //     .toList();
  // <Product> _selectedAnimals2 = [];
  //  final products = <List<Product>>productslists;
//  productlist.map((item) {

//     _selectedAnimals2.add(const Product('19874', 'asdasdasd', 3.99, 2));
//     // var lat2 = double.parse(item['headerprice']);
//     // return Product('19874', 'asdasdasd', 3.99, 2);
//   }).toList();

  // final products = [];
  // productlist.forEach(
  //     (k, v) => products.add(new Product('19874', 'asdasdasd', 3.99, 2)));

  // print(products);
//   // return;

  // final asdsa = [
  //   Product('19874', lorem.sentence(6), 3.99, 2),
  //   Product('98452', lorem.sentence(6), 15, 2)
  // ];

  // print("aaaaaa");
  // print(asdsa);
  // final products = asdsa;
  // final products = <Product>[
  //   Product('19874', lorem.sentence(6), 3.99, 2),
  //   Product('98452', lorem.sentence(6), 15, 2),
  //   Product('28375', lorem.sentence(4), 6.95, 3),
  //   Product('95673', lorem.sentence(3), 49.99, 4),
  //   Product('23763', lorem.sentence(2), 560.03, 1),
  //   Product('55209', lorem.sentence(5), 26, 1),
  //   Product('09853', lorem.sentence(5), 26, 1),
  //   Product('23463', lorem.sentence(5), 34, 1),
  //   Product('56783', lorem.sentence(5), 7, 4),
  //   Product('78256', lorem.sentence(5), 23, 1),
  //   Product('23745', lorem.sentence(5), 94, 1),
  //   Product('07834', lorem.sentence(5), 12, 1),
  //   Product('23547', lorem.sentence(5), 34, 1),
  //   Product('98387', lorem.sentence(5), 7.99, 2),
  // ];
  final date_number = _formatDate(DateTime.now());
  final invoice = Invoice(
    invoiceNumber: invoiceNumber.toString(),
    products: products,
    customerName: customername,
    customerAddress: customeraddress,
    billing_name: billing_name,
    billing_address: billing_name,
    paymentInfo:
        '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: 0,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );
  // print("aaaaa");
  // var pdf = await invoice.buildPdf(PdfPageFormat.a4);
  // await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => pdf.save());

  return await invoice.buildPdf(PdfPageFormat.a4);
}

class _selectedAnimals2 {
  static void add(product) {}
}

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.billing_name,
    required this.billing_address,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List products;
  final String customerName;
  final String customerAddress;
  final String billing_name;
  final String billing_address;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  // String? _logo;

  String? _bgShape;
  String? assetImage;
  buildPdf(PdfPageFormat pageFormat) async {
    print("buildPdf");
    // Create a PDF document.
    final doc = pw.Document();

    // var _logo = await rootBundle.loadString('assets/logo.svg');
    _bgShape = await rootBundle.loadString('assets/invoice.svg');

    // var assetImage = pw.MemoryImage(
    //   (await rootBundle.loadString('assets/invoice.jpg'))
    // );

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    print("saveDocument");
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    // Return the PDF file content

    PdfApi.saveDocument(name: 'karthikk.pdf', pdf: doc);
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(invoiceNumber),
                          pw.Text('Date:'),
                          pw.Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    // child:
                    //     _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        // pw.Container(
        //   height: 20,
        //   width: 100,
        //   child: pw.BarcodeWidget(
        //     barcode: pw.Barcode.pdf417(),
        //     data: 'Invoice# $invoiceNumber',
        //     drawText: false,
        //   ),
        // ),
        // pw.Text(
        //   'Page ${context.pageNumber}/${context.pagesCount}',
        //   style: const pw.TextStyle(
        //     fontSize: 12,
        //     color: PdfColors.white,
        //   ),
        // ),
      ],
    );
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
        // child: pw.Image('assets/design_course/webInterFace.png'),
        // child: pw.Image(assetImage!),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Expanded(
        //   child: pw.Container(
        //     margin: const pw.EdgeInsets.symmetric(horizontal: 20),
        //     height: 70,
        //     child: pw.FittedBox(
        //       child: pw.Text(
        //         'Total: ${_formatCurrency(_grandTotal)}',
        //         style: pw.TextStyle(
        //           color: baseColor,
        //           fontStyle: pw.FontStyle.italic,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice From:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$billing_name\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: billing_address,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice To:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Text(
              //   'Thank you for your business',
              //   style: pw.TextStyle(
              //     color: _darkColor,
              //     fontWeight: pw.FontWeight.bold,
              //   ),
              // ),
              // pw.Container(
              //   margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
              //   child: pw.Text(
              //     'Payment Info:',
              //     style: pw.TextStyle(
              //       color: baseColor,
              //       fontWeight: pw.FontWeight.bold,
              //     ),
              //   ),
              // ),
              // pw.Text(
              //   paymentInfo,
              //   style: const pw.TextStyle(
              //     fontSize: 8,
              //     lineSpacing: 5,
              //     color: _darkColor,
              //   ),
              // ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Sub Total:'),
                    pw.Text(_formatCurrency(_total)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Container(
              //   decoration: pw.BoxDecoration(
              //     border: pw.Border(top: pw.BorderSide(color: accentColor)),
              //   ),
              //   padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
              //   child: pw.Text(
              //     'Terms & Conditions',
              //     style: pw.TextStyle(
              //       fontSize: 12,
              //       color: baseColor,
              //       fontWeight: pw.FontWeight.bold,
              //     ),
              //   ),
              // ),
              // pw.Text(
              //   pw.LoremText().paragraph(40),
              //   textAlign: pw.TextAlign.justify,
              //   style: const pw.TextStyle(
              //     fontSize: 6,
              //     lineSpacing: 2,
              //     color: _darkColor,
              //   ),
              // ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'SKU',
      'Item Description',
      'Price',
      'Tax',
      'Dis',
      'Quantity',
      'Total'
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
        6: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

class Product {
  const Product(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
    this.tax,
  );

  final String sku;
  final String productName;
  final double price;
  final int quantity;
  final String tax;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return tax.toString() + "%";
      case 4:
        return quantity.toString();
      case 5:
        return quantity.toString();
      case 6:
        return _formatCurrency(total);
    }
    return '';
  }
}

  // static Widget buildHeader(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildSupplierAddress(invoice.supplier),
  //             // Container(
  //             //   height: 50,
  //             //   width: 50,
  //             //   child: BarcodeWidget(
  //             //     barcode: Barcode.qrCode(),
  //             //     data: invoice.info.number,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildCustomerAddress(invoice.customer),
  //             buildInvoiceInfo(invoice.info),
  //           ],
  //         ),
  //       ],
  //     );

  // static Widget buildCustomerAddress(Customer customer) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //         Text(customer.address),
  //       ],
  //     );

  // static Widget buildInvoiceInfo(InvoiceInfo info) {
  //   final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
  //   final titles = <String>[
  //     'Invoice Number:',
  //     'Invoice Date:',
  //     'Payment Terms:',
  //     'Due Date:'
  //   ];
  //   final data = <String>[
  //     info.number,
  //     Utils.formatDate(info.date),
  //     paymentTerms,
  //     Utils.formatDate(info.dueDate),
  //   ];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: List.generate(titles.length, (index) {
  //       final title = titles[index];
  //       final value = data[index];

  //       return buildText(title: title, value: value, width: 200);
  //     }),
  //   );
  // }

  // static Widget buildSupplierAddress(Supplier supplier) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(supplier.address),
  //       ],
  //     );

  // static Widget buildTitle(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'INVOICE',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         Text(invoice.info.description),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  // static Widget buildInvoice(Invoice invoice) {
  //   final headers = [
  //     'Description',
  //     'Date',
  //     'Quantity',
  //     'Unit Price',
  //     'VAT',
  //     'Total'
  //   ];
  //   var data = invoice.items.map((item) {
  //     var total = item.unitPrice * item.quantity * (1 + item.vat);

  //     return [
  //       item.description,
  //       Utils.formatDate(item.date),
  //       '${item.quantity}',
  //       '\$ ${item.unitPrice}',
  //       '${item.vat} %',
  //       '\$ ${total.toStringAsFixed(2)}',
  //     ];
  //   }).toList();

  //   return Table.fromTextArray(
  //     headers: headers,
  //     data: data,
  //     border: null,
  //     headerStyle: TextStyle(fontWeight: FontWeight.bold),
  //     headerDecoration: BoxDecoration(color: PdfColors.grey300),
  //     cellHeight: 30,
  //     cellAlignments: {
  //       0: Alignment.centerLeft,
  //       1: Alignment.centerRight,
  //       2: Alignment.centerRight,
  //       3: Alignment.centerRight,
  //       4: Alignment.centerRight,
  //       5: Alignment.centerRight,
  //     },
  //   );
  // }

  // static Widget buildTotal(Invoice invoice) {
  //   final netTotal = invoice.items
  //       .map((item) => item.unitPrice * item.quantity)
  //       .reduce((item1, item2) => item1 + item2);
  //   final vatPercent = invoice.items.first.vat;
  //   final vat = netTotal * vatPercent;
  //   final total = netTotal + vat;

  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: Row(
  //       children: [
  //         Spacer(flex: 6),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildText(
  //                 title: 'Net total',
  //                 value: Utils.formatPrice(netTotal),
  //                 unite: true,
  //               ),
  //               buildText(
  //                 title: 'Vat ${vatPercent * 100} %',
  //                 value: Utils.formatPrice(vat),
  //                 unite: true,
  //               ),
  //               Divider(),
  //               buildText(
  //                 title: 'Total amount due',
  //                 titleStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 value: Utils.formatPrice(total),
  //                 unite: true,
  //               ),
  //               SizedBox(height: 2 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //               SizedBox(height: 0.5 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static Widget buildFooter(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Divider(),
  //         SizedBox(height: 2 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //       ],
  //     );

  // static buildSimpleText({
  //   required String title,
  //   required String value,
  // }) {
  //   final style = TextStyle(fontWeight: FontWeight.bold);

  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //     children: [
  //       Text(title, style: style),
  //       SizedBox(width: 2 * PdfPageFormat.mm),
  //       Text(value),
  //     ],
  //   );
  // }

  // static buildText({
  //   required String title,
  //   required String value,
  //   double width = double.infinity,
  //   TextStyle? titleStyle,
  //   bool unite = false,
  // }) {
  //   final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  //   return Container(
  //     width: width,
  //     child: Row(
  //       children: [
  //         Expanded(child: Text(title, style: style)),
  //         Text(value, style: unite ? style : null),
  //       ],
  //     ),
  //   );
  // }
// }

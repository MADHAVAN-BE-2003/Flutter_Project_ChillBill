import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CardModel {
  String id;
  String client_name;
  String invoicenumber;
  String grandTotal;
  String invoiceDate;
  dynamic itemlistarray;
  dynamic client;
  dynamic company_contact;
  dynamic company_name;
  dynamic company_address;
  dynamic payment_method;
  dynamic customername;
  dynamic customeraddress;
  dynamic customerphone;
  dynamic taxRate;
  dynamic discountRate;
  dynamic inv_tax_status;
  dynamic inv_dis_status;
  dynamic payment_received;
  dynamic payment_balance;
  dynamic payment_words;
  // int height;;
  // String url;
  // String downloadUrl;

  CardModel({
    required this.id,
    required this.client_name,
    required this.invoicenumber,
    required this.grandTotal,
    required this.invoiceDate,
    required this.itemlistarray,
    required this.client,
    required this.company_contact,
    required this.company_name,
    required this.company_address,
    required this.payment_method,
    required this.customername,
    required this.customeraddress,
    required this.customerphone,
    required this.taxRate,
    required this.discountRate,
    required this.inv_tax_status,
    required this.inv_dis_status,
    required this.payment_received,
    required this.payment_balance,
    required this.payment_words,
    // required this.height,
    // required this.url,
    // required this.downloadUrl,
  });

  CardModel fromJson(Map<String, Object> json) => _$CardModelFromJson(json);

  factory CardModel.fromJson(Map<String, Object> json) =>
      _$CardModelFromJson(json);

  // Map<String, Object> toJson() => _$CardModelToJson(this);

  Map<String, dynamic> jsonData() => _$CardModelToJson(this);
}

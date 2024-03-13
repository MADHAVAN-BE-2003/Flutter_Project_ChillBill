// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    id: json['id'] as String,
    client_name: json['client_name'] as String,
    invoicenumber: json['invoicenumber'] as String,
    grandTotal: json['grandTotal'] as String,
    invoiceDate: json['invoiceDate'] as String,
    itemlistarray: json['itemlistarray'] as dynamic,
    company_contact: json['company_contact'] as dynamic,
    client: json['client'] as dynamic,
    company_name: json['company_name'] as dynamic,
    company_address: json['company_address'] as dynamic,
    payment_method: json['payment_method'] as dynamic,
    customername: json['customername'] as dynamic,
    customeraddress: json['customeraddress'] as dynamic,
    customerphone: json['customerphone'] as dynamic,
    taxRate: json['taxRate'] as dynamic,
    discountRate: json['discountRate'] as dynamic,
    inv_tax_status: json['inv_tax_status'] as dynamic,
    inv_dis_status: json['inv_dis_status'] as dynamic,
    payment_received: json['payment_received'] as dynamic,
    payment_balance: json['payment_balance'] as dynamic,
    payment_words: json['payment_words'] as dynamic,

    // height: json['height'] as int,
    // url: json['url'] as String,
    // downloadUrl: json['download_url'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'client_name': instance.client_name,
      'invoicenumber': instance.invoicenumber,
      'grandTotal': instance.grandTotal,
      'invoiceDate': instance.invoiceDate,
      'itemlistarray': instance.itemlistarray,
      'company_contact': instance.company_contact,
      'client': instance.client,
      'company_name': instance.company_name,
      'company_address': instance.company_address,
      'payment_method': instance.payment_method,
      'customername': instance.customername,
      'customeraddress': instance.customeraddress,
      'customerphone': instance.customerphone,
      'taxRate': instance.taxRate,
      'discountRate': instance.discountRate,
      'inv_tax_status': instance.inv_tax_status,
      'inv_dis_status': instance.inv_dis_status,
      'payment_received': instance.payment_received,
      'payment_balance': instance.payment_balance,
      'payment_words': instance.payment_words,
      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

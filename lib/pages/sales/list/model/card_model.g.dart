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
      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

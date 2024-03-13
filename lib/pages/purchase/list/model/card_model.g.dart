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
      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

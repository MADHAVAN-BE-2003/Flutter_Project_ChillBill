// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    tax: json['tax'] as String,
    sale_price: json['sale_price'] as String,
    opening_stock: json['opening_stock'] as String,
    discount: json['discount'] as String,

    // height: json['height'] as int,
    // url: json['url'] as String,
    // downloadUrl: json['download_url'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'tax': instance.tax,
      'sale_price': instance.sale_price,
      'opening_stock': instance.opening_stock,
      'discount': instance.discount,

      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

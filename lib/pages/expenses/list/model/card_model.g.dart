// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    category: json['category'] as String,

    // height: json['height'] as int,
    // url: json['url'] as String,
    // downloadUrl: json['download_url'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,

      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

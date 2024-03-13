// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    user_id: json['user_id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    // height: json['height'] as int,
    // url: json['url'] as String,
    // downloadUrl: json['download_url'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      // 'height': instance.height,
      // 'url': instance.url,
      // 'download_url': instance.downloadUrl,
    };

import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CardModel {
  String id;
  String name;
  String phone;

  // int height;
  // String url;
  // String downloadUrl;

  CardModel({
    required this.id,
    required this.name,
    required this.phone,

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

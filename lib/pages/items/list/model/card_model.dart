import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CardModel {
  String id;
  String name;
  String code;
  String tax;
  String sale_price;
  String opening_stock;
  String discount;

  // int height;
  // String url;
  // String downloadUrl;

  CardModel({
    required this.id,
    required this.name,
    required this.code,
    required this.tax,
    required this.sale_price,
    required this.opening_stock,
    required this.discount,

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

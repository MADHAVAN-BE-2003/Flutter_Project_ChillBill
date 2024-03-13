import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CardModel {
  String id;
  String client_name;
  String invoicenumber;
  String grandTotal;
  String invoiceDate;
  // int height;
  // String url;
  // String downloadUrl;

  CardModel({
    required this.id,
    required this.client_name,
    required this.invoicenumber,
    required this.grandTotal,
    required this.invoiceDate,

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


import 'package:json_annotation/json_annotation.dart';

part 'furniture_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FurnitureModel{

  @JsonKey(name: 'furniture_id')
  int id;

  @JsonKey(name: 'furniture_name')
  String title;

  @JsonKey(name: 'category_name')
  String category;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'description')
  String desc;

  @JsonKey(name: 'room_name')
  String room;

  @JsonKey(name: 'image')
  String imageNames;

  @JsonKey(name:'ar_model')
  String arObj;

  FurnitureModel({required this.id, required this.title, required this.category, required this.price, required this.desc, required this.room, required this.imageNames, required this.arObj});

  factory FurnitureModel.fromJson(Map<String,dynamic> json)=>_$FurnitureModelFromJson(json);
  Map<String,dynamic> toJson() => _$FurnitureModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel{

  @JsonKey(name: 'category_id')
  int id;

  @JsonKey(name: 'category_name')
  String categoryName;

  @JsonKey(name: 'category_image')
  String imageName;

  CategoryModel({required this.id, required this.categoryName, required this.imageName});
  
  factory CategoryModel.fromJson(Map<String,dynamic> json)=>_$CategoryModelFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryModelToJson(this);
}
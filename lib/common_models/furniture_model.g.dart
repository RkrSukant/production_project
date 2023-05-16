// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FurnitureModel _$FurnitureModelFromJson(Map<String, dynamic> json) =>
    FurnitureModel(
      id: json['furniture_id'] as int,
      title: json['furniture_name'] as String,
      category: json['category_name'] as String,
      price: (json['price'] as num).toDouble(),
      desc: json['description'] as String,
      room: json['room_name'] as String,
      imageNames: json['image'] as String,
      arObj: json['ar_model'] as String,
    );

Map<String, dynamic> _$FurnitureModelToJson(FurnitureModel instance) =>
    <String, dynamic>{
      'furniture_id': instance.id,
      'furniture_name': instance.title,
      'category_name': instance.category,
      'price': instance.price,
      'description': instance.desc,
      'room_name': instance.room,
      'image': instance.imageNames,
      'ar_model': instance.arObj,
    };

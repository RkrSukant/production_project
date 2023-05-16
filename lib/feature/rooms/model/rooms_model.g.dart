// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      id: json['room_id'] as int,
      title: json['room_name'] as String,
      imageName: json['room_image'] as String,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'room_id': instance.id,
      'room_name': instance.title,
      'room_image': instance.imageName,
    };


import 'package:json_annotation/json_annotation.dart';

part 'rooms_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomModel{

  @JsonKey(name: 'room_id')
  int id;

  @JsonKey(name: 'room_name')
  String title;

  @JsonKey(name: 'room_image')
  String imageName;

  RoomModel({required this.id,required this.title,required this.imageName});

  factory RoomModel.fromJson(Map<String,dynamic> json)=>_$RoomModelFromJson(json);
  Map<String,dynamic> toJson() => _$RoomModelToJson(this);
}
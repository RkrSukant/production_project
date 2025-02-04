import 'dart:convert';

import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/rooms/data/remote/rooms_remote.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/remote/api_constants.dart';
import 'package:furnihome_ar/remote/dio/base_list_response.dart';
import 'package:furnihome_ar/remote/errors.dart';
import 'package:furnihome_ar/remote/http_client.dart';
import 'package:furnihome_ar/remote/not_null_mapper.dart';

class RoomsRemoteImpl implements RoomsRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<RoomModel>> getRoomList() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.rooms);
      var baseResponse = BaseListResponse<RoomModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => RoomModel.fromJson(response)).toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getRoomFurnitureList(String roomName) async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresByRoom,
          queryParameters: {"roomName": roomName});
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data
            .map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }
}

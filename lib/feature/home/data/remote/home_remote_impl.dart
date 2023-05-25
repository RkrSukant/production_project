import 'dart:convert';

import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/home/data/remote/home_remote.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';
import 'package:production_project/remote/api_constants.dart';
import 'package:production_project/remote/dio/base_list_response.dart';
import 'package:production_project/remote/errors.dart';
import 'package:production_project/remote/http_client.dart';
import 'package:production_project/remote/not_null_mapper.dart';

class HomeRemoteImpl implements HomeRemote {

  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<FurnitureModel>> getFeaturedProducts() async{
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresFeatured
      );
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    }on Exception catch (exception){
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getNewProducts() async{
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresLatest
      );
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    }on Exception catch (exception){
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getArProducts() async{
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresAr
      );
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    }on Exception catch (exception){
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<RoomModel>> getRoomList() async{
    try{
      var result = await _apiClient.dio.get(ApiConstants.rooms);
      var baseResponse = BaseListResponse<RoomModel>.fromJson(json.decode(
          result.toString()), (data){
        return data.map((response) => RoomModel.fromJson(response)).toList();
      });
      return notNullMapperListRest(baseResponse);
    }on Exception catch(exception){
      throw FailedResponseException(exception.toString());
    }
  }

}
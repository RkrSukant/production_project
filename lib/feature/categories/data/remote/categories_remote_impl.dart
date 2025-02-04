import 'dart:convert';

import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/remote/categories_remote.dart';
import 'package:furnihome_ar/feature/categories/model/category_model.dart';
import 'package:furnihome_ar/remote/api_constants.dart';
import 'package:furnihome_ar/remote/dio/base_list_response.dart';
import 'package:furnihome_ar/remote/errors.dart';
import 'package:furnihome_ar/remote/http_client.dart';
import 'package:furnihome_ar/remote/not_null_mapper.dart';

class CategoriesRemoteImpl implements CategoriesRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<CategoryModel>> getCategoryList() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.categories);
      var baseResponse = BaseListResponse<CategoryModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data
            .map((response) => CategoryModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getCategoryFurnitureList(
      String categoryName) async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresByCategory,
          queryParameters: {"categoryName": categoryName});
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

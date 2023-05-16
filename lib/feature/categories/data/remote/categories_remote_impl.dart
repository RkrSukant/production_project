import 'dart:convert';

import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/data/remote/categories_remote.dart';
import 'package:production_project/feature/categories/model/category_model.dart';
import 'package:production_project/remote/api_constants.dart';
import 'package:production_project/remote/dio/base_list_response.dart';
import 'package:production_project/remote/dio/base_response.dart';
import 'package:production_project/remote/errors.dart';
import 'package:production_project/remote/http_client.dart';
import 'package:production_project/remote/not_null_mapper.dart';
import 'package:production_project/utils/image_constants.dart';

class CategoriesRemoteImpl implements CategoriesRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<CategoryModel>>   getCategoryList() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.categories);
      var baseResponse = BaseListResponse<CategoryModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => CategoryModel.fromJson(response))
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
        queryParameters: {"categoryName": categoryName}
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
}

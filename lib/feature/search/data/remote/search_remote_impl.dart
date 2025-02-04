import 'dart:convert';

import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/search/data/remote/search_remote.dart';
import 'package:production_project/remote/api_constants.dart';
import 'package:production_project/remote/dio/base_list_response.dart';
import 'package:production_project/remote/errors.dart';
import 'package:production_project/remote/http_client.dart';
import 'package:production_project/remote/not_null_mapper.dart';

class SearchRemoteImpl implements SearchRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<FurnitureModel>> getFurnitureList() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnitures);
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

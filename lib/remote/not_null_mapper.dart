import 'package:flutter/material.dart';
import 'package:production_project/remote/dio/base_list_response.dart';
import 'package:production_project/remote/dio/base_response.dart';

import 'errors.dart';

List<T> notNullMapperListRest<T>(BaseListResponse<T> baseResponse) {
  if (baseResponse.status == 'Success') {
    var data = baseResponse.data;
    if (data != null) {
      return data;
    }
    throw FailedResponseException("Data is empty.");
  } else {
    printLogMessage(
        'notNullMapperListRest:error ------>${baseResponse.error}');
    throw FailedResponseException(baseResponse.error);
  }
}

T notNullMapperRest<T>(BaseResponse<T> baseResponse) {
  if (baseResponse.status == 200) {
    var data = baseResponse.data;
    if (data != null) {
      return data;
    }
    throw FailedResponseException("Data is empty.");
  } else {
    printLogMessage(
        'notNullMapperListRest:error ------>${baseResponse.error}');
    throw FailedResponseException(baseResponse.error);
  }
}

void printLogMessage(String message) {
  debugPrint(message);
}
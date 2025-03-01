import 'package:dio/dio.dart';
import 'package:furnihome_ar/remote/api_constants.dart';

class ApiClient {
  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json
    );
    final dynamic dio = Dio(options);
    return dio;
  }
}
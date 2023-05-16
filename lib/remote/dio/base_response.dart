class BaseResponse<T> {
  T? data;
  dynamic status;
  String? error;

  BaseResponse({this.status, this.data, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) dataResponse) {
    return BaseResponse<T>(
        status: json["status"],
        data: dataResponse(json["data"]),
        error: json["error"]
    );
  }
}

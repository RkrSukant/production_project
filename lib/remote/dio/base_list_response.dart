class BaseListResponse<T> {
  String status;
  String? error;
  List<T>? data;

  BaseListResponse({required this.status, this.data, this.error});

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, Function(List<dynamic>) build) {
    return BaseListResponse<T>(
        status: json["status"],
        data: build(json["data"]),
        error: json["error"]);
  }
}

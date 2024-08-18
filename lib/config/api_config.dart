class ApiConfig {
  static setHeader({dio, String? token}) async {
    dio.options.headers["Accept"] = "application/json";

    /// set token
    if (token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
  }

  static setPutHeader({dio}) async {
    /// set put
    dio.options.headers["Access-Control-Allow-Methods"] =
        "GET, POST, PUT, DELETE, OPTIONS";
    dio.options.headers["Access-Control-Allow-Headers"] = "*";
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
  }
}

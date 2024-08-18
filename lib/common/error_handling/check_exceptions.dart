
import 'package:dio/dio.dart';
import '../resources/data_state.dart';

class CheckExceptions {
  CheckExceptions(Object? error);

  static Future<DataFailed> response(Response? response) async {
    print(response?.statusCode ?? "aaaa");
    switch (response?.statusCode ?? -1) {
      case 400:
        return DataFailed(response?.data['message'] ?? "Data was wrong");
      case 404:
        return DataFailed("Not Found");
      case 401:
          return DataFailed(response?.data['message'] ?? "Please Login again");
        case 500:
        return DataFailed(response?.data['message'] ?? "Server is Not Responding,");
      default:
        if(response != null){
          return DataFailed(response.data['message'] ?? "Please check your connection");
        }else{
          return const DataFailed("Please check your connection");
        }
    }
  }

  static Future<DataState> getError(Object error) async {
    print("error: " + error.toString());
    if(error is DioException){
      return response(error.response);
    }else{
      print(error.toString());
      return const DataFailed("There is an Error");
    }
  }
}
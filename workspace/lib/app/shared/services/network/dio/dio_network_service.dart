import 'package:workspace/app/shared/services/network/network_exception.dart';
import 'package:workspace/app/shared/services/network/network_response.dart';
import 'package:workspace/app/shared/services/network/network_service.dart';
import 'package:dio/dio.dart';

class DioNetworkService implements NetworkService {
  final Dio _dio;

  DioNetworkService(this._dio);

  @override
  Future<NetworkResponse> getWithParams(
      int page, int amount, String path, String params,
      {bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.get(
        queryParameters: {
          "page": page,
          "amount": amount,
          "params": params,
        },
        path,
        options: Options(
          validateStatus: validateStatus,
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> getByDate(int page, int amount, String path,
      String date, String startDate, String endDate,
      {bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.get(
        queryParameters: {
          "page": page,
          "amount": amount,
          "date": date,
          "startDate": startDate,
          "endDate": endDate,
        },
        path,
        options: Options(
          validateStatus: validateStatus,
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> getWithPageAmount(int page, int amount, String path,
      {bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.get(
        queryParameters: {
          "page": page,
          "amount": amount,
        },
        path,
        options: Options(
          validateStatus: validateStatus,
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> get(String path,
      {bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(
          validateStatus: validateStatus,
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> post(String path,
      {data,
      bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> delete(String path,
      {bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.delete(path,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> put(String path,
      {data,
      bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.put(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> patch(String path,
      {data,
      bool Function(int? statusCode)? validateStatus,
      Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.patch(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioException catch (e) {
      throw NetworkException(
        e.message!,
        e.response?.data,
        type: NetworkExceptionType.values
            .firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }
}

import 'package:workspace/app/shared/services/network/network_response.dart';

abstract class NetworkService {
  Future<NetworkResponse> getWithPageAmount(
    int page,
    int amount,
    String path, {
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> getWithParams(
    int page,
    int amount,
    String path,
    String filter, {
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> getByDate(
    int page,
    int amount,
    String path,
    String date,
    String startDate,
    String endDate, {
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> get(
    String path, {
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> post(
    String path, {
    dynamic data,
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> delete(
    String path, {
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> put(
    String path, {
    dynamic data,
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });

  Future<NetworkResponse> patch(
    String path, {
    dynamic data,
    bool Function(int? statusCode)? validateStatus,
    Map<String, String> headers = const {},
  });
}

import 'package:dio/dio.dart';
import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/infrastructure/adapters/student_adapter.dart';
import 'package:workspace/app/modules/student/infrastructure/datasource/student_datasource.dart';
import 'package:workspace/app/shared/services/network/network_service.dart';

class StudentDatasourceImpl implements IStudentDatasource {
  final NetworkService _service;

  StudentDatasourceImpl(this._service);

  @override
  Future<bool> createStudent(Map<String, dynamic> student) async {
    try {
      await _service.post("/student/create", data: student);
      return true;
    } catch (e) {
      StudentException(
        e.toString(),
        StackTrace.current,
      );
      return false;
    }
  }

  @override
  Future<List<StudentEntity>> listStudents(int page, int amount) async {
    try {
      final listStudent =
          await _service.get("/student/list?limit=$page&offset=$amount");
      final result =
          StudentAdapter.fromListToJson(listStudent.data["students"]);
      return result;
    } on DioException catch (e) {
      throw StudentException(
        e.response?.data['message'],
        StackTrace.current,
      );
    }
  }

  @override
  Future<List<StudentEntity>> listStudentsByParams(
      int page, int amount, String params) async {
    try {
      final listStudent = await _service
          .get("/student/list?limit=$page&offset=$amount&search=$params");
      final result =
          StudentAdapter.fromListToJson(listStudent.data["students"]);
      return result;
    } on DioException catch (e) {
      throw StudentException(
        e.response?.data['message'],
        StackTrace.current,
      );
    }
  }

  @override
  Future<bool> updateStudent(Map<String, dynamic> student) async {
    try {
      await _service.patch("/student/update", data: student);
      return true;
    } catch (e) {
      StudentException(
        e.toString(),
        StackTrace.current,
      );
      return false;
    }
  }
}

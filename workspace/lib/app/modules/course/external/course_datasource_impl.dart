import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/course/infrastructure/adapters/course_adapter.dart';
import 'package:workspace/app/modules/course/infrastructure/datasource/i_course_datasource.dart';
import 'package:workspace/app/shared/services/network/network_exception.dart';
import 'package:workspace/app/shared/services/network/network_service.dart';

class CourseDatasourceImpl implements ICourseDatasource {
  final NetworkService _service;

  CourseDatasourceImpl(this._service);

  @override
  Future<bool> addStudentCourse(Map<String, dynamic> courseStudent) async {
    try {
      await _service.post("/course/add-students", data: courseStudent);
      return true;
    } catch (e) {
      CourseException(
        e.toString(),
        StackTrace.current,
      );
      return false;
    }
  }

  @override
  Future<bool> createCourse(Map<String, dynamic> course) async {
    try {
      await _service.post("/course/create", data: course);
      return true;
    } catch (e) {
      CourseException(
        e.toString(),
        StackTrace.current,
      );
      return false;
    }
  }

  @override
  Future<List<CourseEntity>> filteringCourse(
      int page, int amount, String search) async {
    try {
      final filteringCourse = await _service
          .get("/course/list?limit=$page&offset=$amount&search=$search");
      final result =
          CourseAdapter.fromListToJsonCourse(filteringCourse.data["courses"]);
      return result;
    } on NetworkException catch (e) {
      throw CourseException(
        e.message,
        StackTrace.current,
      );
    }
  }

  @override
  Future<List<CourseEntity>> listAll(int page, int amount) async {
    try {
      final listAll =
          await _service.get("/course/list?limit=$page&offset=$amount");
      final result =
          CourseAdapter.fromListToJsonCourse(listAll.data["courses"]);
      return result;
    } on NetworkException catch (e) {
      throw CourseException(
        e.message,
        StackTrace.current,
      );
    }
  }

  @override
  Future<List<StudentCourseEntity>> listStudents(String search) async {
    try {
      final listAll =
          await _service.get("/course/list-students?search=$search");
      final result =
          CourseAdapter.fromListToJsonStudentCourse(listAll.data["student"]);
      return result;
    } on NetworkException catch (e) {
      throw CourseException(
        e.message,
        StackTrace.current,
      );
    }
  }

  @override
  Future<bool> updateCourse(Map<String, dynamic> course) async {
    try {
      await _service.patch("/course/update", data: course);
      return true;
    } catch (e) {
      CourseException(
        e.toString(),
        StackTrace.current,
      );
      return false;
    }
  }
}

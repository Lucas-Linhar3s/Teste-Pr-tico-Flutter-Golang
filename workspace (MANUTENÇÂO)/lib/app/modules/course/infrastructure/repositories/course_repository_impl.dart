// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/infrastructure/adapters/course_adapter.dart';
import 'package:workspace/app/modules/course/infrastructure/datasource/i_course_datasource.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final ICourseDatasource _datasource;

  CourseRepositoryImpl(this._datasource);

  @override
  Future<bool> addStudentCourse(CourseStudentEntity courseStudent) async {
    bool success = false;

    try {
      final addStudentCourse =
          CourseAdapter.toStudentCourseCreate(courseStudent);
      return await _datasource.addStudentCourse(addStudentCourse);
    } catch (e) {
      return success;
    }
  }

  @override
  Future<bool> createCourse(CourseEntity course) async {
    bool success = false;

    try {
      final createCourse = CourseAdapter.toCourseCreate(course);
      return await _datasource.createCourse(createCourse);
    } catch (e) {
      return success;
    }
  }

  @override
  Future<List<CourseEntity>> filteringCourse(
      int page, int amount, String search) async {
    try {
      final filteringCourse =
          await _datasource.filteringCourse(page, amount, search);
      return filteringCourse;
    } catch (e) {
      throw CourseException(
        e.toString(),
        StackTrace.current,
      );
    }
  }

  @override
  Future<List<CourseEntity>> listAll(int page, int amount) async {
    try {
      final listAll = await _datasource.listAll(page, amount);
      return listAll;
    } catch (e) {
      throw CourseException(
        e.toString(),
        StackTrace.current,
      );
    }
  }

  @override
  Future<List<StudentCourseEntity>> listStudents(String search) async {
    try {
      final listStudents = await _datasource.listStudents(search);
      return listStudents;
    } catch (e) {
      throw CourseException(
        e.toString(),
        StackTrace.current,
      );
    }
  }

  @override
  Future<bool> updateCourse(CourseEntity course) async {
    bool success = false;

    try {
      final updateCourse = CourseAdapter.toCourseUpdate(course);
      return await _datasource.updateCourse(updateCourse);
    } catch (e) {
      return success;
    }
  }
}

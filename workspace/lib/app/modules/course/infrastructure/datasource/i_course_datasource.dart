import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

abstract class ICourseDatasource {
  Future<List<CourseEntity>> listAll(int page, int amount);
  Future<List<CourseEntity>> filteringCourse(
      int page, int amount, String search);
  Future<List<StudentCourseEntity>> listStudents(String search);
  Future<bool> createCourse(Map<String, dynamic> course);
  Future<bool> addStudentCourse(Map<String, dynamic> courseStudent);
  Future<bool> updateCourse(Map<String, dynamic> course);
}

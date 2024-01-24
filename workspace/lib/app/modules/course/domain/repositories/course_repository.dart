import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

abstract class ICourseRepository {
  Future<List<CourseEntity>> listAll(int page, int amount);
  Future<List<CourseEntity>> filteringCourse(
      int page, int amount, String search);
  Future<List<StudentCourseEntity>> listStudents(String search);
  Future<bool> createCourse(CourseEntity course);
  Future<bool> addStudentCourse(CourseStudentEntity courseStudent);
  Future<bool> updateCourse(CourseEntity course);
}

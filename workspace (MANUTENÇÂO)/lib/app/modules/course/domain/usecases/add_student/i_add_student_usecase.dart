import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

abstract class IAddStudentCourseUsecase {
  Future<dynamic> addStudentCourse(CourseStudentEntity courseStudent);
}

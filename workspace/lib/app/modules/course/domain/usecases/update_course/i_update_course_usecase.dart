import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

abstract class IUpdateCourseUsecase {
  Future<dynamic> updateCourse(CourseEntity course);
}

import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

abstract class ICreateCourseUsecase {
  Future<dynamic> createCourse(CourseEntity course);
}

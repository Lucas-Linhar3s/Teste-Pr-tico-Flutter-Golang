// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/update_course/i_update_course_usecase.dart';

class UpdateCourseUsecaseImpl implements IUpdateCourseUsecase {
  final ICourseRepository _repository;

  UpdateCourseUsecaseImpl(this._repository);

  @override
  Future updateCourse(CourseEntity course) async {
    return await _repository.updateCourse(course);
  }
}

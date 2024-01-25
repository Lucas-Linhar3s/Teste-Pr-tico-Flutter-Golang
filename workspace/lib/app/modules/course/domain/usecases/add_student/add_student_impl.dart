import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/add_student/i_add_student_usecase.dart';

class AddStudentUsecaseImpl implements IAddStudentCourseUsecase {
  final ICourseRepository _repository;

  AddStudentUsecaseImpl(this._repository);

  @override
  Future addStudentCourse(CourseStudentEntity courseStudent) async {
    return await _repository.addStudentCourse(courseStudent);
  }
}

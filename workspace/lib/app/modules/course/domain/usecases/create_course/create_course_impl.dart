import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/create_course/I_create_course_usecase.dart';

class CreateCourseUsecaseImpl implements ICreateCourseUsecase {
  final ICourseRepository _courseRepository;

  CreateCourseUsecaseImpl(this._courseRepository);

  @override
  Future createCourse(CourseEntity course) async {
    return await _courseRepository.createCourse(course);
  }
}

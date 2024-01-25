import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_student_course/i_list_student_course_usecase.dart';

class ListStudentCourseImpl implements IListStudentCourseUsecase {
  final ICourseRepository _repository;

  ListStudentCourseImpl(this._repository);

  @override
  Future listStudentCourse(String search) async {
    return await _repository.listStudents(search);
  }
}

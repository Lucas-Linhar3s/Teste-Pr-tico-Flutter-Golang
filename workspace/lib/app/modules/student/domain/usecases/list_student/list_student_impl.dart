import 'package:workspace/app/modules/student/domain/repositories/student_repository.dart';
import 'package:workspace/app/modules/student/domain/usecases/list_student/i_list_student.dart';

class ListStudentUsecaseImpl implements IListStudentUsecase {
  final IStudentRepository _repository;
  ListStudentUsecaseImpl(this._repository);

  @override
  Future listStudentsByParams(int page, int amount, String params) {
    return _repository.listStudentsByParams(page, amount, params);
  }

  @override
  Future listStudent(int page, int amount) {
    return _repository.listStudents(page, amount);
  }
}

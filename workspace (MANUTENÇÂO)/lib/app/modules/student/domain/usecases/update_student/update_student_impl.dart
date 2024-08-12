import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/repositories/student_repository.dart';
import 'package:workspace/app/modules/student/domain/usecases/update_student/i_update_student.dart';

class UpdateStudentUsecaseImpl implements IUpdateStudentUsecase {
  final IStudentRepository _repository;

  UpdateStudentUsecaseImpl(this._repository);

  @override
  Future updateStudentUsecase(StudentEntity student) {
    return _repository.updateStudent(student);
  }
}

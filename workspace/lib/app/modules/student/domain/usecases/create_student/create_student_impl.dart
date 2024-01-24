import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/repositories/student_repository.dart';
import 'package:workspace/app/modules/student/domain/usecases/create_student/i_create_student.dart';

class CreateStudentUsecaseImpl implements ICreateStudentUsecase {
  final IStudentRepository _repository;

  CreateStudentUsecaseImpl(this._repository);

  @override
  Future createStudentUsecase(StudentEntity student) {
    return _repository.createStudent(student);
  }
}

import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';

abstract class ICreateStudentUsecase {
  Future createStudentUsecase(StudentEntity student);
}

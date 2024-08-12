import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';

abstract class IUpdateStudentUsecase {
  Future updateStudentUsecase(StudentEntity student);
}

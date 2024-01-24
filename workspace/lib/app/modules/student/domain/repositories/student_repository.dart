import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';

abstract class IStudentRepository {
  Future<bool> createStudent(StudentEntity student);
  Future<bool> updateStudent(StudentEntity student);
  Future<List<StudentEntity>> listStudents(int page, int amount);
  Future<List<StudentEntity>> listStudentsByParams(
      int page, int amount, String params);
}

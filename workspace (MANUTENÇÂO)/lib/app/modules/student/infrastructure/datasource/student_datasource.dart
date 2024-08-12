import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';

abstract class IStudentDatasource {
  Future<List<StudentEntity>> listStudents(int page, int amount);
  Future<List<StudentEntity>> listStudentsByParams(
      int page, int amount, String params);
  Future<bool> createStudent(Map<String, dynamic> student);
  Future<bool> updateStudent(Map<String, dynamic> student);
}

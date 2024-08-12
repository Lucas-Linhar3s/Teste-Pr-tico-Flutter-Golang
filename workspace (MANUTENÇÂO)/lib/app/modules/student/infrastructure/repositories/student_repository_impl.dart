import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/domain/repositories/student_repository.dart';
import 'package:workspace/app/modules/student/infrastructure/adapters/student_adapter.dart';
import 'package:workspace/app/modules/student/infrastructure/datasource/student_datasource.dart';

class StudentRepositoryImpl implements IStudentRepository {
  final IStudentDatasource _datasource;

  StudentRepositoryImpl(this._datasource);

  @override
  Future<bool> createStudent(StudentEntity student) async {
    bool success = false;

    try {
      final createStudent = StudentAdapter.toJsonCreate(student);
      return await _datasource.createStudent(createStudent);
    } catch (e) {
      return success;
    }
  }

  @override
  Future<List<StudentEntity>> listStudents(int page, int amount) async {
    try {
      final listStudent = await _datasource.listStudents(page, amount);
      return listStudent;
    } catch (e) {
      throw StudentException(
        e.toString(),
        StackTrace.current,
      );
    }
  }

  @override
  Future<bool> updateStudent(StudentEntity student) async {
    bool success = false;

    try {
      final updateStudent = StudentAdapter.toJsonUpdate(student);
      return await _datasource.updateStudent(updateStudent);
    } catch (e) {
      return success;
    }
  }

  @override
  Future<List<StudentEntity>> listStudentsByParams(
      int page, int amount, String params) async {
    try {
      return await _datasource.listStudentsByParams(page, amount, params);
    } catch (e) {
      throw StudentException(
        e.toString(),
        StackTrace.current,
      );
    }
  }
}

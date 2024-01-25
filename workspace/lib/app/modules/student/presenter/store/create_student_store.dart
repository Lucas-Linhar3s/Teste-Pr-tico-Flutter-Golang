import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/domain/usecases/create_student/i_create_student.dart';
part 'create_student_store.g.dart';

class CreateStudentStore = _CreateStudentStoreBase with _$CreateStudentStore;

abstract class _CreateStudentStoreBase with Store {
  final createStudentUsecase = Modular.get<ICreateStudentUsecase>();

  @observable
  var studentEntity = StudentEntity(
    Name: '',
    Code: null,
  );

  @observable
  String name = '';
  @observable
  int code = 0;
  @observable
  String errorMessage = '';

  @action
  setStudentName(String name) => studentEntity.Name = name;
  @action
  setStudentCode(int code) => studentEntity.Code = code;

  @action
  Future<bool> newStudent() async {
    return await _createStudent(studentEntity);
  }

  Future<bool> _createStudent(StudentEntity student) async {
    bool success = false;
    try {
      return await createStudentUsecase.createStudentUsecase(student);
    } on StudentException catch (e) {
      errorMessage = e.message;
    }
    return success;
  }
}

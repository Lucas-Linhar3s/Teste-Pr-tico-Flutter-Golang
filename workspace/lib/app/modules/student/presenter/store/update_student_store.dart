import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/domain/usecases/update_student/i_update_student.dart';
part 'update_student_store.g.dart';

class UpdateStudentStore = _UpdateStudentStoreBase with _$UpdateStudentStore;

abstract class _UpdateStudentStoreBase with Store {
  final updateStudentUsecase = Modular.get<IUpdateStudentUsecase>();

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
  Future<bool> upStudent() async {
    return await _updateStudent(studentEntity);
  }

  Future<bool> _updateStudent(StudentEntity student) async {
    bool success = false;
    try {
      return await updateStudentUsecase.updateStudentUsecase(student);
    } on StudentException catch (e) {
      errorMessage = e.message;
    }
    return success;
  }
}

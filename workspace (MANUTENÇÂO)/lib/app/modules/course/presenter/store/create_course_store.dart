import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/course/domain/usecases/add_student/i_add_student_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/create_course/I_create_course_usecase.dart';
import 'package:workspace/app/shared/services/network/network_exception.dart';
part 'create_course_store.g.dart';

class CreateCourseStore = _CreateCourseStoreBase with _$CreateCourseStore;

abstract class _CreateCourseStoreBase with Store {
  final createCourseUsecase = Modular.get<ICreateCourseUsecase>();
  final addStudentCourseUsecase = Modular.get<IAddStudentCourseUsecase>();

  @observable
  var courseEntity = CourseEntity(
    Description: '',
    Ementa: '',
  );

  @observable
  var courseStudentEntity = CourseStudentEntity(
    CodeCourse: 0,
    CodeStudent: 0,
  );

  @observable
  String description = '';
  @observable
  String ementa = '';
  @observable
  int codeCourse = 0;
  @observable
  int codeStudent = 0;
  @observable
  String errorMessage = '';

  @action
  setCodeCourseStudent(int codeCourse) =>
      courseStudentEntity.CodeCourse = codeCourse;
  @action
  setCodeStudentCourse(int codeStudent) =>
      courseStudentEntity.CodeStudent = codeStudent;
  @action
  setCourseStudentCode(int code) => courseStudentEntity.Code = code;

  @action
  setDescription(String description) => courseEntity.Description = description;
  @action
  setEmenta(String ementa) => courseEntity.Ementa = ementa;

  @action
  Future<bool> newCourse() async {
    return await _createCourse(courseEntity);
  }

  Future<bool> _createCourse(CourseEntity course) async {
    bool success = false;
    try {
      return await createCourseUsecase.createCourse(course);
    } on NetworkException catch (e) {
      errorMessage = e.message;
    }
    return success;
  }

  @action
  Future<bool> addStudentCourse() async {
    return await _addStudentCourse(courseStudentEntity);
  }

  Future<bool> _addStudentCourse(CourseStudentEntity courseStudent) async {
    bool success = false;

    try {
      return await addStudentCourseUsecase.addStudentCourse(courseStudent);
    } on CourseException catch (e) {
      errorMessage = e.message;
    }
    return success;
  }
}

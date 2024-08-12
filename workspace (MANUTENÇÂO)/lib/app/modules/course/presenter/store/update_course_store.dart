import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/course/domain/usecases/update_course/i_update_course_usecase.dart';
part 'update_course_store.g.dart';

class UpdateCourseStore = _UpdateCourseStoreBase with _$UpdateCourseStore;

abstract class _UpdateCourseStoreBase with Store {
  final updateCourseUsecase = Modular.get<IUpdateCourseUsecase>();

  @observable
  var courseEntity = CourseEntity(
    Description: '',
    Ementa: '',
    Code: 0,
  );

  @observable
  String description = '';
  @observable
  int code = 0;
  @observable
  String ementa = '';
  @observable
  String errorMessage = '';

  @action
  setCourseDescription(String description) =>
      courseEntity.Description = description;
  @action
  setCourseEmente(String ementa) => courseEntity.Ementa = ementa;
  @action
  setCourseCode(int code) => courseEntity.Code = code;

  @action
  Future<bool> upCourse() async {
    return await _updateCourse(courseEntity);
  }

  Future<bool> _updateCourse(CourseEntity course) async {
    bool success = false;
    try {
      return await updateCourseUsecase.updateCourse(course);
    } on CourseException catch (e) {
      errorMessage = e.message;
    }
    return success;
  }
}

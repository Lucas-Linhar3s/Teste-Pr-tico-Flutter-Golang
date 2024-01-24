import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';
import 'package:workspace/app/modules/course/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_course/i_list_course_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_student_course/i_list_student_course_usecase.dart';
part 'list_course_store.g.dart';

class ListCourseStore = _ListCourseStoreBase with _$ListCourseStore;

abstract class _ListCourseStoreBase with Store {
  final listCourseUsecase = Modular.get<IListCourseUsecase>();
  final listStudentUsecase = Modular.get<IListStudentCourseUsecase>();

  @observable
  bool loading = false;
  @observable
  List<StudentCourseEntity> listStudentCourse = [];
  @observable
  List<CourseEntity> listCourse = [];
  @observable
  String errorMessage = '';

  @observable
  var idCourse = '';
  @observable
  String search = '';
  @observable
  int limit = 200;
  @observable
  int offset = 0;
  @observable
  bool editing = false;

  @action
  Future<List<CourseEntity>> listAll() async {
    loading = true;

    try {
      listCourse = await listCourseUsecase.listCourse(limit, offset);
      loading = false;
      return listCourse;
    } on CourseException catch (e) {
      errorMessage = e.message;
    }
    return List.empty();
  }

  @action
  Future<List<CourseEntity>> filteringSearch(String filter) async {
    loading = true;
    search = filter.toLowerCase().trim();
    try {
      listCourse =
          await listCourseUsecase.filteringCourse(limit, offset, search);
      loading = false;
      return listCourse;
    } on CourseException catch (e) {
      errorMessage = e.message;
    }
    return List.empty();
  }

  @action
  Future<List<CourseEntity>> listAllStudent(String search) async {
    loading = true;

    try {
      listStudentCourse = await listStudentUsecase.listStudentCourse(search);
      loading = false;
      return listCourse;
    } on CourseException catch (e) {
      errorMessage = e.message;
    }
    return List.empty();
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/domain/usecases/list_student/i_list_student.dart';
import 'package:workspace/app/modules/student/infrastructure/adapters/student_adapter.dart';
part 'list_student_store.g.dart';

class ListStudentStore = _ListStudentStoreBase with _$ListStudentStore;

abstract class _ListStudentStoreBase with Store {
  final listStudentUsecase = Modular.get<IListStudentUsecase>();

  @observable
  bool loading = false;

  @observable
  int? selected;

  @observable
  List<StudentEntity> listStudent = [];

  List<Map<String, dynamic>> listMap = [];

  @observable
  String errorMessage = '';

  @observable
  String search = '';
  @observable
  int limit = 200;
  @observable
  int offset = 0;
  @observable
  int index = 0;

  @observable
  bool editing = false;

  @observable
  int? enable;

  @action
  List<StudentEntity> addNewRow() {
    listMap.insert(0, {
      'name': '',
      'code': 0,
    });
    listStudent.insert(0, StudentAdapter.fromListToJson(listMap).first);
    return listStudent;
  }

  @action
  removeRow(int index) {
    listMap.removeAt(index);
    listStudent.removeAt(index);
  }

  @action
  Future<List<StudentEntity>> listAll() async {
    loading = true;

    try {
      listStudent = await listStudentUsecase.listStudent(limit, offset);
      loading = false;
      return listStudent;
    } on StudentException catch (e) {
      errorMessage = e.message;
    }
    return List.empty();
  }

  @action
  Future<List<StudentEntity>> filteringSearch(String filter) async {
    loading = true;
    search = filter.toLowerCase().trim();
    try {
      listStudent =
          await listStudentUsecase.listStudentsByParams(limit, offset, search);
      loading = false;
      return listStudent;
    } on StudentException catch (e) {
      errorMessage = e.message;
    }
    return List.empty();
  }

  @action
  setSelectedSharedPreferences(int value) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'PageView', value: value.toString());
    selected = value;
  }

  @action
  getSelectedSharedPreferences() async {
    final secureStorage = FlutterSecureStorage();
    String? storedValue = await secureStorage.read(key: 'PageView');
    int retrievedValue = int.tryParse(storedValue ?? '') ?? 0;
    selected = retrievedValue;
    return selected;
  }

  @action
  removeSelectedSharedPreferences() async {
    final secureStorage = FlutterSecureStorage();
    secureStorage.delete(key: "PageView");
    selected = null;
  }
}

import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_windows/flutter_secure_storage_windows.dart';
import 'package:mobx/mobx.dart';
import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';
import 'package:workspace/app/modules/student/domain/exceptions/exception.dart';
import 'package:workspace/app/modules/student/domain/usecases/list_student/i_list_student.dart';
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
    if (listStudent.isEmpty) {
      loading = false;
    }
    listStudent.insert(0, StudentEntity(Name: '', Code: 0));
    return listStudent;
  }

  @action
  removeRow(int index) {
    listStudent.removeAt(index);
    if (listStudent.isEmpty) {
      loading = true;
    }
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
    return listStudent;
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
    return listStudent;
  }

  @action
  setSelectedSharedPreferences(int value) async {
    if (Platform.isLinux) {
      final secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'PageView', value: value.toString());
      selected = value;
    } else {
      var flutterSecureStorageWindowsPlugin = FlutterSecureStorageWindows();
      await flutterSecureStorageWindowsPlugin
          .write(key: 'PageView', value: value.toString(), options: {});
      selected = value;
    }
  }

  @action
  getSelectedSharedPreferences() async {
    if (Platform.isLinux) {
      final secureStorage = FlutterSecureStorage();
      String? storedValue = await secureStorage.read(key: 'PageView');
      int retrievedValue = int.tryParse(storedValue ?? '') ?? 0;
      selected = retrievedValue;
    } else {
      var flutterSecureStorageWindowsPlugin = FlutterSecureStorageWindows();
      String? storedValue = await flutterSecureStorageWindowsPlugin
          .read(key: 'PageView', options: {});
      int retrievedValue = int.tryParse(storedValue ?? '') ?? 0;
      selected = retrievedValue;
    }
  }

  @action
  removeSelectedSharedPreferences() async {
    if (Platform.isLinux) {
      final secureStorage = FlutterSecureStorage();
      secureStorage.delete(key: "PageView");
      selected = null;
    } else {
      var flutterSecureStorageWindowsPlugin = FlutterSecureStorageWindows();
      flutterSecureStorageWindowsPlugin.delete(key: "PageView", options: {});
      selected = null;
    }
  }
}

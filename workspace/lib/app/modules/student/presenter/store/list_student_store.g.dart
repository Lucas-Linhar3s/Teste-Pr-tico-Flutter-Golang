// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_student_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListStudentStore on _ListStudentStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ListStudentStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$selectedAtom =
      Atom(name: '_ListStudentStoreBase.selected', context: context);

  @override
  int? get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(int? value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  late final _$listStudentAtom =
      Atom(name: '_ListStudentStoreBase.listStudent', context: context);

  @override
  List<StudentEntity> get listStudent {
    _$listStudentAtom.reportRead();
    return super.listStudent;
  }

  @override
  set listStudent(List<StudentEntity> value) {
    _$listStudentAtom.reportWrite(value, super.listStudent, () {
      super.listStudent = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ListStudentStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchAtom =
      Atom(name: '_ListStudentStoreBase.search', context: context);

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$limitAtom =
      Atom(name: '_ListStudentStoreBase.limit', context: context);

  @override
  int get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(int value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  late final _$offsetAtom =
      Atom(name: '_ListStudentStoreBase.offset', context: context);

  @override
  int get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(int value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  late final _$indexAtom =
      Atom(name: '_ListStudentStoreBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$editingAtom =
      Atom(name: '_ListStudentStoreBase.editing', context: context);

  @override
  bool get editing {
    _$editingAtom.reportRead();
    return super.editing;
  }

  @override
  set editing(bool value) {
    _$editingAtom.reportWrite(value, super.editing, () {
      super.editing = value;
    });
  }

  late final _$enableAtom =
      Atom(name: '_ListStudentStoreBase.enable', context: context);

  @override
  int? get enable {
    _$enableAtom.reportRead();
    return super.enable;
  }

  @override
  set enable(int? value) {
    _$enableAtom.reportWrite(value, super.enable, () {
      super.enable = value;
    });
  }

  late final _$listAllAsyncAction =
      AsyncAction('_ListStudentStoreBase.listAll', context: context);

  @override
  Future<List<StudentEntity>> listAll() {
    return _$listAllAsyncAction.run(() => super.listAll());
  }

  late final _$filteringSearchAsyncAction =
      AsyncAction('_ListStudentStoreBase.filteringSearch', context: context);

  @override
  Future<List<StudentEntity>> filteringSearch(String filter) {
    return _$filteringSearchAsyncAction
        .run(() => super.filteringSearch(filter));
  }

  late final _$setSelectedSharedPreferencesAsyncAction = AsyncAction(
      '_ListStudentStoreBase.setSelectedSharedPreferences',
      context: context);

  @override
  Future setSelectedSharedPreferences(int value) {
    return _$setSelectedSharedPreferencesAsyncAction
        .run(() => super.setSelectedSharedPreferences(value));
  }

  late final _$getSelectedSharedPreferencesAsyncAction = AsyncAction(
      '_ListStudentStoreBase.getSelectedSharedPreferences',
      context: context);

  @override
  Future getSelectedSharedPreferences() {
    return _$getSelectedSharedPreferencesAsyncAction
        .run(() => super.getSelectedSharedPreferences());
  }

  late final _$removeSelectedSharedPreferencesAsyncAction = AsyncAction(
      '_ListStudentStoreBase.removeSelectedSharedPreferences',
      context: context);

  @override
  Future removeSelectedSharedPreferences() {
    return _$removeSelectedSharedPreferencesAsyncAction
        .run(() => super.removeSelectedSharedPreferences());
  }

  late final _$_ListStudentStoreBaseActionController =
      ActionController(name: '_ListStudentStoreBase', context: context);

  @override
  List<StudentEntity> addNewRow() {
    final _$actionInfo = _$_ListStudentStoreBaseActionController.startAction(
        name: '_ListStudentStoreBase.addNewRow');
    try {
      return super.addNewRow();
    } finally {
      _$_ListStudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeRow(int index) {
    final _$actionInfo = _$_ListStudentStoreBaseActionController.startAction(
        name: '_ListStudentStoreBase.removeRow');
    try {
      return super.removeRow(index);
    } finally {
      _$_ListStudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
selected: ${selected},
listStudent: ${listStudent},
errorMessage: ${errorMessage},
search: ${search},
limit: ${limit},
offset: ${offset},
index: ${index},
editing: ${editing},
enable: ${enable}
    ''';
  }
}

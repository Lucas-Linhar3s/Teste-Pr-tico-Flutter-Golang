// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListCourseStore on _ListCourseStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ListCourseStoreBase.loading', context: context);

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

  late final _$listStudentCourseAtom =
      Atom(name: '_ListCourseStoreBase.listStudentCourse', context: context);

  @override
  List<StudentCourseEntity> get listStudentCourse {
    _$listStudentCourseAtom.reportRead();
    return super.listStudentCourse;
  }

  @override
  set listStudentCourse(List<StudentCourseEntity> value) {
    _$listStudentCourseAtom.reportWrite(value, super.listStudentCourse, () {
      super.listStudentCourse = value;
    });
  }

  late final _$listCourseAtom =
      Atom(name: '_ListCourseStoreBase.listCourse', context: context);

  @override
  List<CourseEntity> get listCourse {
    _$listCourseAtom.reportRead();
    return super.listCourse;
  }

  @override
  set listCourse(List<CourseEntity> value) {
    _$listCourseAtom.reportWrite(value, super.listCourse, () {
      super.listCourse = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ListCourseStoreBase.errorMessage', context: context);

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

  late final _$idCourseAtom =
      Atom(name: '_ListCourseStoreBase.idCourse', context: context);

  @override
  String get idCourse {
    _$idCourseAtom.reportRead();
    return super.idCourse;
  }

  @override
  set idCourse(String value) {
    _$idCourseAtom.reportWrite(value, super.idCourse, () {
      super.idCourse = value;
    });
  }

  late final _$searchAtom =
      Atom(name: '_ListCourseStoreBase.search', context: context);

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
      Atom(name: '_ListCourseStoreBase.limit', context: context);

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
      Atom(name: '_ListCourseStoreBase.offset', context: context);

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

  late final _$editingAtom =
      Atom(name: '_ListCourseStoreBase.editing', context: context);

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

  late final _$listAllAsyncAction =
      AsyncAction('_ListCourseStoreBase.listAll', context: context);

  @override
  Future<List<CourseEntity>> listAll() {
    return _$listAllAsyncAction.run(() => super.listAll());
  }

  late final _$filteringSearchAsyncAction =
      AsyncAction('_ListCourseStoreBase.filteringSearch', context: context);

  @override
  Future<List<CourseEntity>> filteringSearch(String filter) {
    return _$filteringSearchAsyncAction
        .run(() => super.filteringSearch(filter));
  }

  late final _$listAllStudentAsyncAction =
      AsyncAction('_ListCourseStoreBase.listAllStudent', context: context);

  @override
  Future<List<CourseEntity>> listAllStudent(String search) {
    return _$listAllStudentAsyncAction.run(() => super.listAllStudent(search));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
listStudentCourse: ${listStudentCourse},
listCourse: ${listCourse},
errorMessage: ${errorMessage},
idCourse: ${idCourse},
search: ${search},
limit: ${limit},
offset: ${offset},
editing: ${editing}
    ''';
  }
}

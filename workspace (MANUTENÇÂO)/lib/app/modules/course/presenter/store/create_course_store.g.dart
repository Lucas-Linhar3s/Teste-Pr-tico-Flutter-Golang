// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateCourseStore on _CreateCourseStoreBase, Store {
  late final _$courseEntityAtom =
      Atom(name: '_CreateCourseStoreBase.courseEntity', context: context);

  @override
  CourseEntity get courseEntity {
    _$courseEntityAtom.reportRead();
    return super.courseEntity;
  }

  @override
  set courseEntity(CourseEntity value) {
    _$courseEntityAtom.reportWrite(value, super.courseEntity, () {
      super.courseEntity = value;
    });
  }

  late final _$courseStudentEntityAtom = Atom(
      name: '_CreateCourseStoreBase.courseStudentEntity', context: context);

  @override
  CourseStudentEntity get courseStudentEntity {
    _$courseStudentEntityAtom.reportRead();
    return super.courseStudentEntity;
  }

  @override
  set courseStudentEntity(CourseStudentEntity value) {
    _$courseStudentEntityAtom.reportWrite(value, super.courseStudentEntity, () {
      super.courseStudentEntity = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateCourseStoreBase.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$ementaAtom =
      Atom(name: '_CreateCourseStoreBase.ementa', context: context);

  @override
  String get ementa {
    _$ementaAtom.reportRead();
    return super.ementa;
  }

  @override
  set ementa(String value) {
    _$ementaAtom.reportWrite(value, super.ementa, () {
      super.ementa = value;
    });
  }

  late final _$codeCourseAtom =
      Atom(name: '_CreateCourseStoreBase.codeCourse', context: context);

  @override
  int get codeCourse {
    _$codeCourseAtom.reportRead();
    return super.codeCourse;
  }

  @override
  set codeCourse(int value) {
    _$codeCourseAtom.reportWrite(value, super.codeCourse, () {
      super.codeCourse = value;
    });
  }

  late final _$codeStudentAtom =
      Atom(name: '_CreateCourseStoreBase.codeStudent', context: context);

  @override
  int get codeStudent {
    _$codeStudentAtom.reportRead();
    return super.codeStudent;
  }

  @override
  set codeStudent(int value) {
    _$codeStudentAtom.reportWrite(value, super.codeStudent, () {
      super.codeStudent = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CreateCourseStoreBase.errorMessage', context: context);

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

  late final _$newCourseAsyncAction =
      AsyncAction('_CreateCourseStoreBase.newCourse', context: context);

  @override
  Future<bool> newCourse() {
    return _$newCourseAsyncAction.run(() => super.newCourse());
  }

  late final _$addStudentCourseAsyncAction =
      AsyncAction('_CreateCourseStoreBase.addStudentCourse', context: context);

  @override
  Future<bool> addStudentCourse() {
    return _$addStudentCourseAsyncAction.run(() => super.addStudentCourse());
  }

  late final _$_CreateCourseStoreBaseActionController =
      ActionController(name: '_CreateCourseStoreBase', context: context);

  @override
  dynamic setCodeCourseStudent(int codeCourse) {
    final _$actionInfo = _$_CreateCourseStoreBaseActionController.startAction(
        name: '_CreateCourseStoreBase.setCodeCourseStudent');
    try {
      return super.setCodeCourseStudent(codeCourse);
    } finally {
      _$_CreateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCodeStudentCourse(int codeStudent) {
    final _$actionInfo = _$_CreateCourseStoreBaseActionController.startAction(
        name: '_CreateCourseStoreBase.setCodeStudentCourse');
    try {
      return super.setCodeStudentCourse(codeStudent);
    } finally {
      _$_CreateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCourseStudentCode(int code) {
    final _$actionInfo = _$_CreateCourseStoreBaseActionController.startAction(
        name: '_CreateCourseStoreBase.setCourseStudentCode');
    try {
      return super.setCourseStudentCode(code);
    } finally {
      _$_CreateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDescription(String description) {
    final _$actionInfo = _$_CreateCourseStoreBaseActionController.startAction(
        name: '_CreateCourseStoreBase.setDescription');
    try {
      return super.setDescription(description);
    } finally {
      _$_CreateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEmenta(String ementa) {
    final _$actionInfo = _$_CreateCourseStoreBaseActionController.startAction(
        name: '_CreateCourseStoreBase.setEmenta');
    try {
      return super.setEmenta(ementa);
    } finally {
      _$_CreateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courseEntity: ${courseEntity},
courseStudentEntity: ${courseStudentEntity},
description: ${description},
ementa: ${ementa},
codeCourse: ${codeCourse},
codeStudent: ${codeStudent},
errorMessage: ${errorMessage}
    ''';
  }
}

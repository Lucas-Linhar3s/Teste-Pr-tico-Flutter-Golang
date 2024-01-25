// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateCourseStore on _UpdateCourseStoreBase, Store {
  late final _$courseEntityAtom =
      Atom(name: '_UpdateCourseStoreBase.courseEntity', context: context);

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

  late final _$descriptionAtom =
      Atom(name: '_UpdateCourseStoreBase.description', context: context);

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

  late final _$codeAtom =
      Atom(name: '_UpdateCourseStoreBase.code', context: context);

  @override
  int get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(int value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$ementaAtom =
      Atom(name: '_UpdateCourseStoreBase.ementa', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_UpdateCourseStoreBase.errorMessage', context: context);

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

  late final _$upCourseAsyncAction =
      AsyncAction('_UpdateCourseStoreBase.upCourse', context: context);

  @override
  Future<bool> upCourse() {
    return _$upCourseAsyncAction.run(() => super.upCourse());
  }

  late final _$_UpdateCourseStoreBaseActionController =
      ActionController(name: '_UpdateCourseStoreBase', context: context);

  @override
  dynamic setCourseDescription(String description) {
    final _$actionInfo = _$_UpdateCourseStoreBaseActionController.startAction(
        name: '_UpdateCourseStoreBase.setCourseDescription');
    try {
      return super.setCourseDescription(description);
    } finally {
      _$_UpdateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCourseEmente(String ementa) {
    final _$actionInfo = _$_UpdateCourseStoreBaseActionController.startAction(
        name: '_UpdateCourseStoreBase.setCourseEmente');
    try {
      return super.setCourseEmente(ementa);
    } finally {
      _$_UpdateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCourseCode(int code) {
    final _$actionInfo = _$_UpdateCourseStoreBaseActionController.startAction(
        name: '_UpdateCourseStoreBase.setCourseCode');
    try {
      return super.setCourseCode(code);
    } finally {
      _$_UpdateCourseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courseEntity: ${courseEntity},
description: ${description},
code: ${code},
ementa: ${ementa},
errorMessage: ${errorMessage}
    ''';
  }
}

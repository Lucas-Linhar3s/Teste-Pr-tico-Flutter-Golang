// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_student_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateStudentStore on _UpdateStudentStoreBase, Store {
  late final _$studentEntityAtom =
      Atom(name: '_UpdateStudentStoreBase.studentEntity', context: context);

  @override
  StudentEntity get studentEntity {
    _$studentEntityAtom.reportRead();
    return super.studentEntity;
  }

  @override
  set studentEntity(StudentEntity value) {
    _$studentEntityAtom.reportWrite(value, super.studentEntity, () {
      super.studentEntity = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UpdateStudentStoreBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$codeAtom =
      Atom(name: '_UpdateStudentStoreBase.code', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_UpdateStudentStoreBase.errorMessage', context: context);

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

  late final _$upStudentAsyncAction =
      AsyncAction('_UpdateStudentStoreBase.upStudent', context: context);

  @override
  Future<bool> upStudent() {
    return _$upStudentAsyncAction.run(() => super.upStudent());
  }

  late final _$_UpdateStudentStoreBaseActionController =
      ActionController(name: '_UpdateStudentStoreBase', context: context);

  @override
  dynamic setStudentName(String name) {
    final _$actionInfo = _$_UpdateStudentStoreBaseActionController.startAction(
        name: '_UpdateStudentStoreBase.setStudentName');
    try {
      return super.setStudentName(name);
    } finally {
      _$_UpdateStudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStudentCode(int code) {
    final _$actionInfo = _$_UpdateStudentStoreBaseActionController.startAction(
        name: '_UpdateStudentStoreBase.setStudentCode');
    try {
      return super.setStudentCode(code);
    } finally {
      _$_UpdateStudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
studentEntity: ${studentEntity},
name: ${name},
code: ${code},
errorMessage: ${errorMessage}
    ''';
  }
}

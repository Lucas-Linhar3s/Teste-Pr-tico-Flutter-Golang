// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_student_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateStudentStore on _CreateStudentStoreBase, Store {
  late final _$studentEntityAtom =
      Atom(name: '_CreateStudentStoreBase.studentEntity', context: context);

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
      Atom(name: '_CreateStudentStoreBase.name', context: context);

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
      Atom(name: '_CreateStudentStoreBase.code', context: context);

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
      Atom(name: '_CreateStudentStoreBase.errorMessage', context: context);

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

  late final _$newStudentAsyncAction =
      AsyncAction('_CreateStudentStoreBase.newStudent', context: context);

  @override
  Future<bool> newStudent() {
    return _$newStudentAsyncAction.run(() => super.newStudent());
  }

  late final _$_CreateStudentStoreBaseActionController =
      ActionController(name: '_CreateStudentStoreBase', context: context);

  @override
  dynamic setStudentName(String name) {
    final _$actionInfo = _$_CreateStudentStoreBaseActionController.startAction(
        name: '_CreateStudentStoreBase.setStudentName');
    try {
      return super.setStudentName(name);
    } finally {
      _$_CreateStudentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStudentCode(int code) {
    final _$actionInfo = _$_CreateStudentStoreBaseActionController.startAction(
        name: '_CreateStudentStoreBase.setStudentCode');
    try {
      return super.setStudentCode(code);
    } finally {
      _$_CreateStudentStoreBaseActionController.endAction(_$actionInfo);
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

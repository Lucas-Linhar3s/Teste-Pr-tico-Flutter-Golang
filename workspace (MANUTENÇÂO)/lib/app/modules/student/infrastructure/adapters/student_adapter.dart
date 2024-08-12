import 'package:workspace/app/modules/student/domain/entities/student_entity.dart';

class StudentAdapter {
  StudentAdapter._();

  static StudentEntity fromJson(Map<String, dynamic> studentMap) {
    return StudentEntity(
      Code: studentMap['code'],
      Name: studentMap['name'],
    );
  }

  static Map<String, dynamic> toJsonUpdate(StudentEntity student) {
    return {
      'code': student.Code,
      'name': student.Name,
    };
  }

  static Map<String, dynamic> toJsonCreate(StudentEntity student) {
    return {
      'name': student.Name,
    };
  }

  static List<StudentEntity> fromListToJson(json) {
    final castedList = List.castFrom<dynamic, Map<String, dynamic>>(json);
    final parsedList = castedList
        .map((personMap) => StudentAdapter.fromJson(personMap))
        .toList();
    return parsedList;
  }
}

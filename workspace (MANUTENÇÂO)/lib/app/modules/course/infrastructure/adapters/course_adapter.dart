import 'package:workspace/app/modules/course/domain/entities/course_entity.dart';

class CourseAdapter {
  CourseAdapter._();

  static CourseEntity fromJsonCourse(Map<String, dynamic> json) {
    return CourseEntity(
      Code: json['code'],
      Description: json['description'],
      Ementa: json['ementa'],
    );
  }

  static StudentCourseEntity fromJsonStudentCourse(Map<String, dynamic> json) {
    return StudentCourseEntity(
      Name: json['name'],
      Code: json['code'],
    );
  }

  static Map<String, dynamic> toCourseCreate(CourseEntity course) {
    return {
      'description': course.Description,
      'ementa': course.Ementa,
    };
  }

  static Map<String, dynamic> toCourseUpdate(CourseEntity course) {
    return {
      'code': course.Code,
      'description': course.Description,
      'ementa': course.Ementa,
    };
  }

  static Map<String, dynamic> toStudentCourseCreate(
      CourseStudentEntity course) {
    return {
      'code_course': course.CodeCourse,
      'code_student': course.CodeStudent,
    };
  }

  static List<CourseEntity> fromListToJsonCourse(json) {
    final castedList = List.castFrom<dynamic, Map<String, dynamic>>(json);
    final parsedList = castedList
        .map((personMap) => CourseAdapter.fromJsonCourse(personMap))
        .toList();
    return parsedList;
  }

  static List<StudentCourseEntity> fromListToJsonStudentCourse(json) {
    final castedList = List.castFrom<dynamic, Map<String, dynamic>>(json);
    final parsedList = castedList
        .map((personMap) => CourseAdapter.fromJsonStudentCourse(personMap))
        .toList();
    return parsedList;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class CourseEntity {
  int? Code;
  String Description;
  String Ementa;
  CourseEntity({
    this.Code,
    required this.Description,
    required this.Ementa,
  });

  CourseEntity copyWith({
    int? Code,
    String? Description,
    String? Ementa,
  }) {
    return CourseEntity(
      Code: Code ?? this.Code,
      Description: Description ?? this.Description,
      Ementa: Ementa ?? this.Ementa,
    );
  }
}

class StudentCourseEntity {
  int? Code;
  String Name;
  StudentCourseEntity({
    this.Code,
    required this.Name,
  });

  StudentCourseEntity copyWith({
    int? Code,
    String? Name,
  }) {
    return StudentCourseEntity(
      Code: Code ?? this.Code,
      Name: Name ?? this.Name,
    );
  }
}

class CourseStudentEntity {
  int? Code;
  int CodeCourse;
  int CodeStudent;
  CourseStudentEntity({
    this.Code,
    required this.CodeCourse,
    required this.CodeStudent,
  });

  CourseStudentEntity copyWith({
    int? Code,
    int? CodeCourse,
    int? CodeStudent,
  }) {
    return CourseStudentEntity(
      Code: Code ?? this.Code,
      CodeCourse: CodeCourse ?? this.CodeCourse,
      CodeStudent: CodeStudent ?? this.CodeStudent,
    );
  }
}

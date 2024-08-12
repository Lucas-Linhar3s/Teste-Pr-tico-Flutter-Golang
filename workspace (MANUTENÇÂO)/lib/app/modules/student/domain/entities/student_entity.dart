class StudentEntity {
  int? Code;
  String Name;
  StudentEntity({
    this.Code,
    required this.Name,
  });

  StudentEntity copyWith({
    int? Code,
    String? Name,
  }) {
    return StudentEntity(
      Code: Code ?? this.Code,
      Name: Name ?? this.Name,
    );
  }
}

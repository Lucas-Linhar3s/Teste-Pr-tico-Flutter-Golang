abstract class IListStudentUsecase {
  Future listStudent(int page, int amount);
  Future listStudentsByParams(int page, int amount, String params);
}

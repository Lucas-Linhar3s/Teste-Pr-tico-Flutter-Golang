abstract class IListCourseUsecase {
  Future<dynamic> listCourse(int page, int amount);
  Future<dynamic> filteringCourse(int page, int amount, String search);
}

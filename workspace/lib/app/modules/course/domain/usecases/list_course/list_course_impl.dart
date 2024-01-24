import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_course/i_list_course_usecase.dart';

class ListCourseUsecaseImpl implements IListCourseUsecase {
  final ICourseRepository _repository;

  ListCourseUsecaseImpl(this._repository);

  @override
  Future filteringCourse(int page, int amount, String search) async {
    return await _repository.filteringCourse(page, amount, search);
  }

  @override
  Future listCourse(int page, int amount) async {
    return await _repository.listAll(page, amount);
  }
}

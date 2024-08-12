import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/domain/repositories/course_repository.dart';
import 'package:workspace/app/modules/course/domain/usecases/add_student/add_student_impl.dart';
import 'package:workspace/app/modules/course/domain/usecases/add_student/i_add_student_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/create_course/I_create_course_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/create_course/create_course_impl.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_course/i_list_course_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_course/list_course_impl.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_student_course/i_list_student_course_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/list_student_course/list_student_course_impl.dart';
import 'package:workspace/app/modules/course/domain/usecases/update_course/i_update_course_usecase.dart';
import 'package:workspace/app/modules/course/domain/usecases/update_course/update_course_impl.dart';
import 'package:workspace/app/modules/course/external/course_datasource_impl.dart';
import 'package:workspace/app/modules/course/infrastructure/datasource/i_course_datasource.dart';
import 'package:workspace/app/modules/course/infrastructure/repositories/course_repository_impl.dart';
import 'package:workspace/app/modules/course/presenter/ui/pages/course_page.dart';
import 'package:workspace/app/shared/services/network/dio/dio_network_service.dart';
import 'package:workspace/app/shared/services/network/network_service.dart';

class CourseModule extends Module {
  @override
  void binds(i) {
    i.add<ICourseDatasource>(CourseDatasourceImpl.new);
    i.add<ICourseRepository>(CourseRepositoryImpl.new);
    i.add<IListCourseUsecase>(ListCourseUsecaseImpl.new);
    i.add<IUpdateCourseUsecase>(UpdateCourseUsecaseImpl.new);
    i.add<ICreateCourseUsecase>(CreateCourseUsecaseImpl.new);
    i.add<IAddStudentCourseUsecase>(AddStudentUsecaseImpl.new);
    i.add<IListStudentCourseUsecase>(ListStudentCourseImpl.new);
    i.add<NetworkService>(DioNetworkService.new);
    i.addInstance(Dio(BaseOptions(
      baseUrl: "http://localhost:3000",
    )));
  }

  @override
  void routes(r) {
    r.child("/", child: (ctx) => const CoursePage());
  }
}

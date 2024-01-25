import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/course_module.dart';
import 'package:workspace/app/modules/course/presenter/ui/pages/page_details.dart';
import 'package:workspace/app/modules/home_page.dart';
import 'package:workspace/app/modules/student/domain/repositories/student_repository.dart';
import 'package:workspace/app/modules/student/domain/usecases/create_student/create_student_impl.dart';
import 'package:workspace/app/modules/student/domain/usecases/create_student/i_create_student.dart';
import 'package:workspace/app/modules/student/domain/usecases/list_student/i_list_student.dart';
import 'package:workspace/app/modules/student/domain/usecases/list_student/list_student_impl.dart';
import 'package:workspace/app/modules/student/domain/usecases/update_student/i_update_student.dart';
import 'package:workspace/app/modules/student/domain/usecases/update_student/update_student_impl.dart';
import 'package:workspace/app/modules/student/external/datasource/student_datasource.dart';
import 'package:workspace/app/modules/student/infrastructure/datasource/student_datasource.dart';
import 'package:workspace/app/modules/student/infrastructure/repositories/student_repository_impl.dart';
import 'package:workspace/app/modules/student/presenter/store/create_student_store.dart';
import 'package:workspace/app/modules/student/student_module.dart';
import 'package:workspace/app/shared/services/network/dio/dio_network_service.dart';
import 'package:workspace/app/shared/services/network/network_service.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<IStudentDatasource>(StudentDatasourceImpl.new);
    i.add<IStudentRepository>(StudentRepositoryImpl.new);
    i.add<IListStudentUsecase>(ListStudentUsecaseImpl.new);
    i.add<IUpdateStudentUsecase>(UpdateStudentUsecaseImpl.new);
    i.add<ICreateStudentUsecase>(CreateStudentUsecaseImpl.new);
    i.add(CreateStudentStore.new);
    i.add<NetworkService>(DioNetworkService.new);
    i.addInstance(Dio(BaseOptions(
      baseUrl: "http://localhost:3000",
    )));
  }

  @override
  void routes(r) {
    r.child("/", child: (ctx) => HomePage(), children: [
      ModuleRoute('students', module: StudentModule()),
      ModuleRoute("courses", module: CourseModule()),
      ChildRoute("/courses/details", child: (context) => const PageDetails())
    ]);
    r.wildcard(
        child: (context) => const Scaffold(
              body: Center(
                child: Text("Page not found"),
              ),
            ));
  }
}

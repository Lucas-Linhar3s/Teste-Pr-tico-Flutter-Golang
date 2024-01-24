// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';

class ModalAddStudentCourse {
  BuildContext context;
  String codeCourse;
  ListStudentStore listStudentStore;
  ListCourseStore listCourseStore;
  CreateCourseStore createCourseStore;
  ModalAddStudentCourse({
    required this.context,
    required this.codeCourse,
    required this.listStudentStore,
    required this.listCourseStore,
    required this.createCourseStore,
  });
  call() async {
    return await showDialog(
        context: context,
        builder: (_) => Observer(
              builder: (_) {
                return Dialog(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 440,
                        height: 410,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Adicionar aluno ao curso",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 360,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Pesquisa pelo nome do aluno',
                                  labelText: 'Nome do aluno',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF77B7CC), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2.0,
                                      color: Color.fromARGB(255, 210, 210, 210),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(85, 217, 217, 217),
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                onChanged: listStudentStore.filteringSearch,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 200,
                              width: 400,
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    borderOnForeground: true,
                                    child: Observer(
                                      builder: (_) {
                                        return ListTile(
                                          onTap: () async {
                                            createCourseStore
                                                .setCodeCourseStudent(
                                                    int.parse(codeCourse));
                                            createCourseStore
                                                .setCodeStudentCourse(
                                                    listStudentStore
                                                        .listStudent[index]
                                                        .Code!);
                                            var success =
                                                await createCourseStore
                                                    .addStudentCourse();
                                            if (success) {
                                              Modular.to.pop();
                                              await CoolAlert.show(
                                                width: 500,
                                                context: context,
                                                type: CoolAlertType.success,
                                                title:
                                                    "Aluno cadastrado no curso",
                                                onConfirmBtnTap: () {
                                                  Modular.to.canPop();
                                                  listCourseStore
                                                      .listAllStudent(
                                                          codeCourse);
                                                },
                                              );
                                            } else {
                                              await CoolAlert.show(
                                                width: 500,
                                                context: context,
                                                type: CoolAlertType.error,
                                                title:
                                                    "Erro ao cadastrar aluno no curso",
                                                onConfirmBtnTap: () {
                                                  Modular.to.canPop();
                                                },
                                              );
                                            }
                                          },
                                          title: Text(
                                            listStudentStore
                                                .listStudent[index].Name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                              "Matricula: ${listStudentStore.listStudent[index].Code}"),
                                          leading: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(Icons.book_outlined),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) => const Divider(),
                                itemCount: listStudentStore.listStudent.length,
                              ),
                            ),
                          ],
                        )));
              },
            ));
  }
}

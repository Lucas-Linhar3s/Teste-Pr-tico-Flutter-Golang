// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/update_course_store.dart';

class ModalEditCourse {
  TextEditingController controllerDescription;
  TextEditingController controllerEmenta;
  BuildContext context;
  ListCourseStore listCourseStore;
  UpdateCourseStore updateCourseStore;
  ModalEditCourse({
    required this.controllerDescription,
    required this.controllerEmenta,
    required this.context,
    required this.listCourseStore,
    required this.updateCourseStore,
  });

  call() async {
    return await showDialog(
        context: context,
        builder: (_) => Dialog(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                width: 440,
                height: 290,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Editar Curso",
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 360,
                      child: TextFormField(
                        controller: controllerDescription,
                        decoration: InputDecoration(
                          hintText: 'Insira uma descrição',
                          labelText: 'Descrição',
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
                          fillColor: const Color.fromARGB(85, 217, 217, 217),
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
                        onChanged: (value) {
                          updateCourseStore.description = value;
                          updateCourseStore.setCourseDescription(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 360,
                      child: TextFormField(
                        controller: controllerEmenta,
                        decoration: InputDecoration(
                          hintText: 'Insira uma ementa',
                          labelText: 'Ementa',
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
                          fillColor: const Color.fromARGB(85, 217, 217, 217),
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
                        onChanged: (value) {
                          updateCourseStore.ementa = value;
                          updateCourseStore.setCourseEmente(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          right: 40.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 226, 206, 91))),
                              child: Text('Cancelar'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Observer(
                              builder: (_) {
                                return ElevatedButton(
                                  onPressed: controllerDescription
                                              .text.isEmpty ||
                                          controllerEmenta.text.isEmpty
                                      ? null
                                      : () async {
                                          var success = await updateCourseStore
                                              .upCourse();
                                          if (success) {
                                            Modular.to.pop();
                                            await CoolAlert.show(
                                              width: 500,
                                              context: context,
                                              type: CoolAlertType.success,
                                              title: "Curso editado",
                                              onConfirmBtnTap: () {
                                                listCourseStore.listAll();
                                              },
                                              closeOnConfirmBtnTap: true,
                                            );
                                          } else {
                                            await CoolAlert.show(
                                              width: 500,
                                              context: context,
                                              type: CoolAlertType.error,
                                              title: "Erro ao editar curso",
                                              closeOnConfirmBtnTap: true,
                                            );
                                          }
                                        },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          controllerDescription.text.isEmpty ||
                                                  controllerEmenta.text.isEmpty
                                              ? Color.fromARGB(
                                                  255, 164, 189, 199)
                                              : Color(0xff2ecc71))),
                                  child: Text('Salvar'),
                                );
                              },
                            )
                          ],
                        ))
                  ],
                ))));
  }
}

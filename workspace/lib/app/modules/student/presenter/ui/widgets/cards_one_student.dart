// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, sort_child_properties_last, prefer_const_declarations, must_be_immutable
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/student/presenter/store/create_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/update_student_store.dart';

class CardsOneStudent extends StatefulWidget {
  ListStudentStore store;
  CreateStudentStore createStudentStore;
  UpdateStudentStore updateStudentStore;
  TextEditingController controllerName;

  CardsOneStudent({
    Key? key,
    required this.store,
    required this.createStudentStore,
    required this.updateStudentStore,
    required this.controllerName,
  }) : super(key: key);

  @override
  State<CardsOneStudent> createState() => _CardsOneStudentState();
}

class _CardsOneStudentState extends State<CardsOneStudent> {
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double fullHdBreakpointWidth = 1340.00;
    return Observer(
      builder: (_) {
        return widget.store.loading
            ? const Padding(
                padding: EdgeInsets.only(top: 260.0),
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 15.0),
                child: SizedBox(
                    width:
                        screenWidth < fullHdBreakpointWidth ? screenWidth : 900,
                    height: screenWidth < fullHdBreakpointWidth ? 400 : 600,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Observer(
                            builder: (_) {
                              return ListTile(
                                title: widget.store.enable == index
                                    ? TextFormField(
                                        controller: widget.controllerName,
                                        onChanged: (value) {
                                          widget.createStudentStore.name =
                                              value;
                                          widget.updateStudentStore.name =
                                              value;
                                          widget.createStudentStore
                                              .setStudentName(value);
                                          widget.updateStudentStore
                                              .setStudentName(value);
                                        },
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFF77B7CC),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          hintText: "Nome do aluno",
                                          labelStyle: TextStyle(
                                              color: myFocusNode.hasFocus
                                                  ? const Color(0xFF77B7CC)
                                                  : const Color(0xFF77B7CC)),
                                        ),
                                      )
                                    : Text(
                                        widget.store.listStudent[index].Name),
                                subtitle: Text(
                                    "Matricula: ${widget.store.listStudent[index].Code}"),
                                leading: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.person_4_outlined),
                                ),
                                trailing: Tooltip(
                                    message: "Salvar",
                                    child: Observer(
                                      builder: (_) {
                                        return widget.store.enable == index
                                            ? ElevatedButton(
                                                onPressed: widget
                                                            .createStudentStore
                                                            .name
                                                            .isEmpty &&
                                                        widget
                                                            .updateStudentStore
                                                            .name
                                                            .isEmpty
                                                    ? null
                                                    : () async {
                                                        if (widget
                                                            .store.editing) {
                                                          var successEditing =
                                                              await widget
                                                                  .updateStudentStore
                                                                  .upStudent();

                                                          if (successEditing) {
                                                            widget.store
                                                                .enable = null;
                                                            widget.store
                                                                    .editing =
                                                                false;
                                                            await CoolAlert
                                                                .show(
                                                              width: 500,
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .success,
                                                              title:
                                                                  "Aluno editado",
                                                              onConfirmBtnTap:
                                                                  () {
                                                                widget.store
                                                                        .editing =
                                                                    false;
                                                                widget.store
                                                                        .enable =
                                                                    null;
                                                                widget.store
                                                                    .listAll();
                                                              },
                                                            );
                                                          } else {
                                                            await CoolAlert
                                                                .show(
                                                              width: 500,
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .error,
                                                              title:
                                                                  "Erro ao editar aluno",
                                                              onConfirmBtnTap:
                                                                  () => Modular
                                                                      .to
                                                                      .pop(),
                                                            );
                                                          }
                                                        } else {
                                                          bool success =
                                                              await widget
                                                                  .createStudentStore
                                                                  .newStudent();

                                                          if (success) {
                                                            widget.store
                                                                .enable = null;
                                                            await CoolAlert
                                                                .show(
                                                              width: 500,
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .success,
                                                              title:
                                                                  "Aluno cadastrado",
                                                              onConfirmBtnTap:
                                                                  () {
                                                                widget.store
                                                                        .editing =
                                                                    false;
                                                                widget.store
                                                                        .enable =
                                                                    null;
                                                                widget.store
                                                                    .listAll();
                                                              },
                                                            );
                                                          } else {
                                                            await CoolAlert
                                                                .show(
                                                              width: 500,
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .error,
                                                              title:
                                                                  "Erro ao cadastrar aluno",
                                                              onConfirmBtnTap:
                                                                  () => Modular
                                                                      .to
                                                                      .pop(),
                                                            );
                                                          }
                                                        }
                                                      },
                                                child: const Icon(Icons.check),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          widget.store.editing
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  213, 223, 106)
                                                              : const Color(
                                                                  0xff2ecc71)),
                                                ))
                                            : ElevatedButton(
                                                onPressed: widget
                                                            .store.editing ||
                                                        widget.store.enable !=
                                                            null
                                                    ? null
                                                    : () {
                                                        widget.store.index =
                                                            index;
                                                        widget.store.editing =
                                                            true;
                                                        widget.store.enable =
                                                            index;
                                                        widget.updateStudentStore
                                                                .name =
                                                            widget
                                                                .store
                                                                .listStudent[
                                                                    index]
                                                                .Name;
                                                        widget.controllerName
                                                                .text =
                                                            widget
                                                                .store
                                                                .listStudent[
                                                                    index]
                                                                .Name;
                                                        widget
                                                            .updateStudentStore
                                                            .setStudentCode(
                                                                widget
                                                                    .store
                                                                    .listStudent[
                                                                        index]
                                                                    .Code!);
                                                        widget
                                                            .updateStudentStore
                                                            .setStudentName(
                                                                widget
                                                                    .store
                                                                    .listStudent[
                                                                        index]
                                                                    .Name);
                                                      },
                                                child: const Icon(Icons.edit),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          widget.store.enable != null
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  164, 189, 199)
                                                              : const Color(
                                                                  0xff87ceeb)),
                                                ));
                                      },
                                    )),
                              );
                            },
                          ),
                          borderOnForeground: true,
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: widget.store.listStudent.length,
                    )));
      },
    );
  }
}

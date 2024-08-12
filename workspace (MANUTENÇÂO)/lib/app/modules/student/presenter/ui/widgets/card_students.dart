// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:workspace/app/modules/student/presenter/store/create_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/update_student_store.dart';
import 'package:workspace/app/modules/student/presenter/ui/widgets/cards_one_student.dart';

class CardStudents extends StatefulWidget {
  ListStudentStore store;
  CreateStudentStore createStudentStore;
  UpdateStudentStore updateStudentStore;
  CardStudents({
    Key? key,
    required this.store,
    required this.createStudentStore,
    required this.updateStudentStore,
  }) : super(key: key);

  @override
  State<CardStudents> createState() => _CardStudentsState();
}

class _CardStudentsState extends State<CardStudents> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerName = TextEditingController();

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double fullHdBreakpointWidth = 1340.00;

    return SizedBox(
        width: screenWidth < fullHdBreakpointWidth ? screenWidth : 900,
        height: screenWidth < fullHdBreakpointWidth ? 570 : 800,
        child: Card(
            elevation: 10,
            color: Colors.white,
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 15.0, top: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Alunos",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    Observer(
                      builder: (_) {
                        return widget.store.editing == true ||
                                widget.store.enable != null
                            ? Tooltip(
                                message: "Cancelar",
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.redAccent)),
                                  onPressed: () {
                                    if (widget.store.editing == false) {
                                      widget.store
                                          .removeRow(widget.store.index);
                                    }
                                    controllerName.text = '';
                                    widget.store.editing = false;
                                    widget.store.enable = null;
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: widget.store.enable == 0
                                    ? null
                                    : () {
                                        widget.store.editing = false;
                                        widget.store.enable = 0;
                                        controllerName.text = '';
                                        widget.updateStudentStore.name = '';
                                        widget.createStudentStore.name = '';
                                        widget.store.addNewRow();
                                      },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        widget.store.enable != null
                                            ? const Color.fromARGB(
                                                255, 164, 189, 199)
                                            : const Color(0xff2ecc71))),
                                child: const Text(
                                  "Novo Aluno",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0, right: 15.0),
                child: Divider(),
              ),
              CardsOneStudent(
                store: widget.store,
                createStudentStore: widget.createStudentStore,
                controllerName: controllerName,
                updateStudentStore: widget.updateStudentStore,
              ),
              SizedBox(
                height: 20,
              ),
              Observer(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Total de alunos: ${widget.store.listStudent.length}",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                  );
                },
              )
            ])));
  }
}

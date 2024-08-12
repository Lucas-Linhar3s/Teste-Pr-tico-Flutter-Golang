// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/card_details_content.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/modal_add_student_course.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';

class CardDetails extends StatefulWidget {
  TextEditingController code;
  TextEditingController description;
  TextEditingController ementa;
  ListCourseStore listCourseStore;
  CreateCourseStore createCourseStore;
  CardDetails({
    Key? key,
    required this.code,
    required this.description,
    required this.ementa,
    required this.listCourseStore,
    required this.createCourseStore,
  }) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    ListStudentStore listStudentStore = ListStudentStore();
    ModalAddStudentCourse modalAddStudentCourse = ModalAddStudentCourse(
      context: context,
      listStudentStore: listStudentStore,
      codeCourse: widget.code.text,
      listCourseStore: widget.listCourseStore,
      createCourseStore: widget.createCourseStore,
    );
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    const double fullHdBreakpointWidth = 1340.00;
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
                    const Text("Detalhes do Curso",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    ElevatedButton(
                      onPressed: () {
                        modalAddStudentCourse.call();
                        listStudentStore.listAll();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff2ecc71))),
                      child: const Text(
                        "Adicionar aluno",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0, right: 15.0),
                child: Divider(),
              ),
              CardDetailsContent(
                code: widget.code,
                description: widget.description,
                ementa: widget.ementa,
                listCourseStore: widget.listCourseStore,
              )
            ])));
  }
}

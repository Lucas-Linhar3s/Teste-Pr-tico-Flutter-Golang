// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/update_course_store.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/cards_courses_contents.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/modal_new_course.dart';

class CardCourses extends StatefulWidget {
  CreateCourseStore createCourseStore;
  ListCourseStore listCourseStore;
  UpdateCourseStore updateCourseStore;
  CardCourses({
    Key? key,
    required this.createCourseStore,
    required this.listCourseStore,
    required this.updateCourseStore,
  }) : super(key: key);

  @override
  State<CardCourses> createState() => _CardCoursesState();
}

class _CardCoursesState extends State<CardCourses> {
  @override
  Widget build(BuildContext context) {
    ModalNewCourse modalNewCourse = ModalNewCourse(
        context: context,
        listCourseStore: widget.listCourseStore,
        createCourseStore: widget.createCourseStore);
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
                    const Text("Cursos",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    ElevatedButton(
                      onPressed: () {
                        modalNewCourse.call();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff2ecc71))),
                      child: const Text(
                        "Novo Curso",
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
              CardsCoursesContent(
                  createCourseStore: widget.createCourseStore,
                  listCourseStore: widget.listCourseStore,
                  updateCourseStore: widget.updateCourseStore)
            ])));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/update_course_store.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/modal_edit_course.dart';

class CardsCoursesContent extends StatefulWidget {
  CreateCourseStore createCourseStore;
  ListCourseStore listCourseStore;
  UpdateCourseStore updateCourseStore;
  CardsCoursesContent({
    Key? key,
    required this.createCourseStore,
    required this.listCourseStore,
    required this.updateCourseStore,
  }) : super(key: key);

  @override
  State<CardsCoursesContent> createState() => _CardsCoursesContentState();
}

class _CardsCoursesContentState extends State<CardsCoursesContent> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerDescription = TextEditingController();
    TextEditingController controllerEmenta = TextEditingController();
    ModalEditCourse modalEditCourse = ModalEditCourse(
        controllerDescription: controllerDescription,
        controllerEmenta: controllerEmenta,
        context: context,
        listCourseStore: widget.listCourseStore,
        updateCourseStore: widget.updateCourseStore);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double fullHdBreakpointWidth = 1340.00;
    return Observer(
      builder: (_) {
        return widget.listCourseStore.loading
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
                          borderOnForeground: true,
                          child: Observer(
                            builder: (_) {
                              return ListTile(
                                  title: Text(
                                    widget.listCourseStore.listCourse[index]
                                        .Description,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      "Ementa: ${widget.listCourseStore.listCourse[index].Ementa}"),
                                  leading: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.book_outlined,
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Tooltip(
                                          message: "Editar curso",
                                          child: ElevatedButton(
                                              onPressed: () {
                                                widget.updateCourseStore
                                                    .setCourseCode(widget
                                                        .listCourseStore
                                                        .listCourse[index]
                                                        .Code!);
                                                widget.updateCourseStore
                                                    .setCourseDescription(widget
                                                        .listCourseStore
                                                        .listCourse[index]
                                                        .Description);
                                                widget.updateCourseStore
                                                    .setCourseEmente(widget
                                                        .listCourseStore
                                                        .listCourse[index]
                                                        .Ementa);
                                                controllerDescription.text =
                                                    widget
                                                        .listCourseStore
                                                        .listCourse[index]
                                                        .Description;
                                                controllerEmenta.text = widget
                                                    .listCourseStore
                                                    .listCourse[index]
                                                    .Ementa;
                                                modalEditCourse.call();
                                              },
                                              child: Icon(Icons.edit_outlined),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        const Color.fromARGB(
                                                            255,
                                                            213,
                                                            223,
                                                            106)),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Tooltip(
                                          message: "Detalhes do curso",
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Modular.to.pushNamed(
                                                    "/courses/details",
                                                    arguments: [
                                                      widget
                                                          .listCourseStore
                                                          .listCourse[index]
                                                          .Code,
                                                      widget
                                                          .listCourseStore
                                                          .listCourse[index]
                                                          .Description,
                                                      widget
                                                          .listCourseStore
                                                          .listCourse[index]
                                                          .Ementa
                                                    ]);
                                              },
                                              child: Icon(Icons.info_outline),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        const Color(
                                                            0xff87ceeb)),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: widget.listCourseStore.listCourse.length,
                    )));
      },
    );
  }
}

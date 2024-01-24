// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';

class CardDetailsContent extends StatefulWidget {
  TextEditingController code;
  TextEditingController description;
  TextEditingController ementa;
  ListCourseStore listCourseStore;

  CardDetailsContent({
    Key? key,
    required this.code,
    required this.description,
    required this.ementa,
    required this.listCourseStore,
  }) : super(key: key);

  @override
  State<CardDetailsContent> createState() => _CardDetailsContentState();
}

class _CardDetailsContentState extends State<CardDetailsContent> {
  @override
  void initState() {
    widget.listCourseStore.listAllStudent(widget.code.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double fullHdBreakpointWidth = 1340.00;
    return Observer(
      builder: (_) {
        return Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 15.0),
            child: SizedBox(
                width: screenWidth < fullHdBreakpointWidth ? screenWidth : 900,
                height: screenWidth < fullHdBreakpointWidth ? 400 : 600,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Código: ${widget.code.text}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Descrição",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(widget.description.text)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Ementa",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 30),
                          child: Text(widget.ementa.text)),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Alunos: ${widget.listCourseStore.listStudentCourse.length}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                                backgroundColor: widget.listCourseStore
                                            .listStudentCourse.length ==
                                        0
                                    ? MaterialStatePropertyAll(
                                        Color(0xffdc3545))
                                    : MaterialStatePropertyAll(widget
                                                .listCourseStore
                                                .listStudentCourse
                                                .length >=
                                            10
                                        ? Color(0xff2ecc71)
                                        : Color(0xffffc107))),
                            child: widget.listCourseStore.listStudentCourse
                                        .length ==
                                    0
                                ? Text("Vazio",
                                    style: TextStyle(color: Colors.white))
                                : Text(
                                    widget.listCourseStore.listStudentCourse
                                                .length >=
                                            10
                                        ? "Completo"
                                        : "Em Formação",
                                    style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: screenWidth < fullHdBreakpointWidth
                            ? screenWidth
                            : 900,
                        height: screenWidth < fullHdBreakpointWidth ? 160 : 345,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  width: screenWidth < fullHdBreakpointWidth
                                      ? screenWidth
                                      : 900,
                                  height: 400,
                                  child: ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        elevation: 2,
                                        color: Colors.white,
                                        borderOnForeground: true,
                                        child: Observer(
                                          builder: (_) {
                                            return ListTile(
                                              title: Text(
                                                widget
                                                    .listCourseStore
                                                    .listStudentCourse[index]
                                                    .Name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                  "Matricula: ${widget.listCourseStore.listStudentCourse[index].Code}"),
                                              leading: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child:
                                                    Icon(Icons.person_outline),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const Divider(),
                                    itemCount: widget.listCourseStore
                                        .listStudentCourse.length,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ])));
      },
    );
  }
}

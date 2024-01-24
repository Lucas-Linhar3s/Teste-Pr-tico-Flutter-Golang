// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:workspace/app/modules/student/presenter/store/create_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';
import 'package:workspace/app/modules/student/presenter/store/update_student_store.dart';
import 'package:workspace/app/modules/student/presenter/ui/widgets/card_students.dart';
import 'package:workspace/app/shared/widgets/custom_search.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  ListStudentStore store = ListStudentStore();
  CreateStudentStore createStudentStore = CreateStudentStore();
  UpdateStudentStore updateStudentStore = UpdateStudentStore();

  filter(String params) {
    store.filteringSearch(params.trim());
  }

  @override
  void initState() {
    store.listAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerSerach = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    const double fullHdBreakpointWidth = 1340.00;
    const double fullHdBreakpointHeight = 769.00;
    return Scaffold(
      backgroundColor: const Color(0xfff0f8ff),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              screenWidth < fullHdBreakpointWidth
                  ? SizedBox(
                      width: screenWidth < fullHdBreakpointWidth ? 40 : 90,
                    )
                  : Expanded(child: Container()),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomSearch(
                        searchController: controllerSerach,
                        hintTextSearch: "Pesquisa por nome do aluno",
                        onChanged: filter,
                        preffixIconSearch: const Icon(Icons.search_outlined),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CardStudents(
                        createStudentStore: createStudentStore,
                        store: store,
                        updateStudentStore: updateStudentStore,
                      ),
                    ],
                  )),
              Expanded(flex: 1, child: Container())
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/update_course_store.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/card_course.dart';
import 'package:workspace/app/shared/widgets/custom_search.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  ListCourseStore listCourseStore = ListCourseStore();
  UpdateCourseStore updateCourseStore = UpdateCourseStore();
  CreateCourseStore createCourseStore = CreateCourseStore();

  filter(String params) {
    listCourseStore.filteringSearch(params.trim());
  }

  @override
  void initState() {
    listCourseStore.listAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerSerach = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    const double fullHdBreakpointWidth = 1340.00;

    return Scaffold(
      backgroundColor: const Color(0xfff0f8ff),
      body: SizedBox(
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
                        hintTextSearch: "Pesquisar curso",
                        onChanged: filter,
                        preffixIconSearch: const Icon(Icons.search_outlined),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CardCourses(
                          createCourseStore: createCourseStore,
                          listCourseStore: listCourseStore,
                          updateCourseStore: updateCourseStore)
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

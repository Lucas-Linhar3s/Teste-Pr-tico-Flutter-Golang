import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/course/presenter/store/create_course_store.dart';
import 'package:workspace/app/modules/course/presenter/store/list_course_store.dart';
import 'package:workspace/app/modules/course/presenter/ui/widgets/card_details.dart';

class PageDetails extends StatefulWidget {
  const PageDetails({super.key});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  final TextEditingController code = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController ementa = TextEditingController();
  ListCourseStore listCourseStore = ListCourseStore();
  CreateCourseStore createCourseStore = CreateCourseStore();

  @override
  Widget build(BuildContext context) {
    final List? args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>?;
    if (args![0] != null) {
      String myString = '${args[0]}';
      code.text = myString;
    }
    if (args[1] != null) {
      description.text = args[1];
    }
    if (args[2] != null) {
      ementa.text = args[2];
    }
    if (args == null) {
      Modular.to.navigate('/courses/');
    }
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    const double fullHdBreakpointWidth = 1340.00;
    return Scaffold(
      backgroundColor: const Color(0xfff0f8ff),
      body: Column(
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Modular.to.navigate("/courses/");
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 99, 99, 99),
                    size: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Icon(
                    Icons.book_outlined,
                    color: Color(0xFFababab),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Cursos',
                      style: TextStyle(
                        color: Color(0xFFababab),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('  >  '),
                    Text(
                      'Detalhes',
                      style: TextStyle(
                        color: Color(0xFF595959),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      screenWidth < fullHdBreakpointWidth
                          ? SizedBox(
                              width:
                                  screenWidth < fullHdBreakpointWidth ? 40 : 90,
                            )
                          : Expanded(child: Container()),
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              CardDetails(
                                  code: code,
                                  description: description,
                                  ementa: ementa,
                                  listCourseStore: listCourseStore,
                                  createCourseStore: createCourseStore)
                            ],
                          )),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

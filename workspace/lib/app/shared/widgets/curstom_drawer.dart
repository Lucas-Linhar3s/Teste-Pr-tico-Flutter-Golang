import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workspace/app/modules/student/presenter/store/list_student_store.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  ListStudentStore home = ListStudentStore();

  @override
  void initState() {
    home.getSelectedSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          child: Drawer(
            backgroundColor: Color(0xff87ceeb),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("Menu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        )),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: home.selected == 0
                              ? Color.fromARGB(255, 15, 104, 206)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        enabled: true,
                        leading:
                            Icon(Icons.person_2_outlined, color: Colors.white),
                        title: Text("Alunos",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Modular.to.navigate("/students/");
                          home.setSelectedSharedPreferences(0);
                          home.removeSelectedSharedPreferences();
                        },
                        hoverColor: Colors.black26,
                      ),
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                          color: home.selected == 1
                              ? Color.fromARGB(255, 15, 104, 206)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        enabled: true,
                        leading: Icon(Icons.description_outlined,
                            color: Colors.white),
                        title: Text("Cursos",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Modular.to.navigate("/courses/");
                          home.setSelectedSharedPreferences(1);
                          home.removeSelectedSharedPreferences();
                        },
                        hoverColor: Colors.black26,
                      ),
                    ),
                    Divider(),
                  ]),
            ),
          ),
          width: 300,
          height: 240,
        );
      },
    );
  }
}

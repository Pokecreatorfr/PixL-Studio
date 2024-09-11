import 'package:flutter/material.dart';
import 'package:pixlstudio/ui/homepage/top_bar.dart';
import 'package:pixlstudio/ui/homepage/side_bar.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/ui/map_editor/map_editor.dart';
import 'package:pixlstudio/ui/homepage/open_project.dart';
import 'package:pixlstudio/services/project_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget page = const MapEditor();

  @override
  void initState() {
    super.initState();
  }

  void changePage(Widget newPage) {
    setState(() {
      page = newPage;
    });
  }

  void setStates() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: Column(
          children: [
            const TopBar(),
            ProjectService.path != null
                ? Expanded(
                    child: Container(
                      color: AppColor.primary,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SideBar(changePage: changePage),
                          Expanded(
                            child: page,
                          ),
                        ],
                      ),
                    ),
                  )
                : OpenProject(changePage: setStates),
          ],
        ),
      ),
    );
  }
}

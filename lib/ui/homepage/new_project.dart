import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pixlstudio/ui/homepage/top_bar.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pixlstudio/services/project_service.dart';

class NewProject extends StatefulWidget {
  const NewProject({super.key, required this.changePage});

  final Function() changePage;

  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  String path = '';

  final TextEditingController _pathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            const TopBar(),
            const SubTopBar(),
            Expanded(
              child: Container(
                color: AppColor.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Path to new project',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Pixelify Sans",
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // text field for path
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: TextField(
                            controller: _pathController,
                            decoration: const InputDecoration(
                              hintText: 'Path to new project',
                              hintStyle: TextStyle(
                                color: AppColor.tertiary,
                                fontFamily: "Pixelify Sans",
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Pixelify Sans",
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                            onChanged: (value) {
                              // Met à jour la variable `path` à chaque modification du texte
                              setState(() {
                                path = value;
                              });
                            },
                          ),
                        ),
                        // browse button
                        MaterialButton(
                          minWidth: 100,
                          height: 50,
                          color: AppColor.secondary,
                          hoverColor: AppColor.yellow,
                          onPressed: () async {
                            final String result =
                                await FilePicker.platform.getDirectoryPath() ??
                                    '';

                            if (result == '') {
                              return;
                            }
                            setState(() {
                              path = result;
                              _pathController.text = path;
                            });
                          },
                          child: const Text(
                            'Browse',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Pixelify Sans",
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                        color: AppColor.secondary,
                        hoverColor: AppColor.green,
                        onPressed: () async {
                          bool exists = Directory(path).existsSync();
                          if (exists) {
                            createNewProject(path);
                            if (ProjectService.OpenProject(path)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Project created successfully")),
                              );
                              widget.changePage();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Error while creating the project, please try again")),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "The path doesn't exist, please choose a valid path")),
                            );
                          }
                        },
                        child: const Text(
                          'Create Project',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Pixelify Sans",
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubTopBar extends StatelessWidget {
  const SubTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                // return to previous page
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 30)),
        ],
      ),
    );
  }
}

void createNewProject(String path) {
  Directory(path).createSync(recursive: true);
  Directory('$path/Data').createSync();
  Directory('$path/Data/Maps').createSync();
  Directory('$path/Data/Tilesets').createSync();
  Directory('$path/Data/Scripts').createSync();
  Directory('$path/Data/Assets').createSync();
  Directory('$path/Data/Assets/Images').createSync();
  Directory('$path/Data/Assets/Audios').createSync();
  Directory('$path/Data/Assets/Fonts').createSync();

  File('$path/Data/Assets/assets.pixl').createSync();

  File('$path/Data/Tilesets/tilesets.pixl').createSync();

  Map tilesets = {
    'tilesets': [],
  };

  File('$path/Data/Tilesets/tilesets.pixl')
      .writeAsStringSync(jsonEncode(tilesets));

  File('$path/project.pixl').createSync();

  Map project = {
    'version': '0.0.1',
    'map directory': 'Data\\Maps',
    'tileset directory': 'Data\\Tilesets',
    'script directory': 'Data\\Scripts',
    'assets directory': 'Data\\Assets',
  };

  File('$path/project.pixl').writeAsStringSync(jsonEncode(project));
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/ui/homepage/new_project.dart';

class OpenProject extends StatelessWidget {
  OpenProject({super.key, required this.changePage});

  final Function() changePage;

  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: AppColor.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 300,
                color: AppColor.secondary,
                hoverColor: AppColor.yellow,
                onPressed: () async {
                  // open pixl file, only one file window
                  result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pixl'],
                  );
                },
                child: const Text(
                  'Open Project',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Pixelify Sans",
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: 300,
                color: AppColor.secondary,
                hoverColor: AppColor.green,
                onPressed: () {
                  // create new project
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewProject(changePage: changePage)),
                  );
                },
                child: const Text(
                  'New Project',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Pixelify Sans",
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

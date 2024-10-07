import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/services/asset_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pixlstudio/services/project_service.dart';

class ImageManager extends StatefulWidget {
  const ImageManager({Key? key}) : super(key: key);

  @override
  _ImageManagerState createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  List<Asset> images = [];

  @override
  void initState() {
    images = AssetService().getAssetsByType(AssetType.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: Column(
        children: [
          Container(
            color: AppColor.secondary,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // add image button
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: AppColor.primary,
                  ),
                  onPressed: () {
                    // open image selection dialog here and add image to assets
                    FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg', 'jpeg'],
                    ).then((value) {
                      if (value != null) {
                        File file = File(value.files.single.path!);
                        String name = file.path.split("\\").last;
                        // copy file to assets folder
                        String path =
                            "${ProjectService.path!}\\${ProjectService.assets_path!}\\Images\\$name";

                        // create directory if not exists and catch error
                        try {
                          Directory(
                                  "${ProjectService.path!}\\${ProjectService.assets_path!}\\Images")
                              .createSync();
                          // copy file to assets folder
                          file.copySync(path);
                        } catch (e) {
                          print(e);
                        }

                        AssetService().addAsset(Asset(
                            name,
                            "${ProjectService.assets_path!}\\Images\\$name",
                            AssetType.image));
                        setState(() {
                          images =
                              AssetService().getAssetsByType(AssetType.image);
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            // Ajout de Expanded ici pour donner une contrainte au Row
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Nombre de colonnes dans la grille
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColor.secondary,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.file(
                          File(
                              '${ProjectService.path!}\\${images[index].path}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        images[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Pixelify Sans",
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

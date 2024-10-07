import 'package:flutter/material.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/services/asset_service.dart';
import 'package:pixlstudio/ui/assets_manager/image_category.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetService().loadAssets();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: (constraints.maxHeight / 2) - 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width:
                    constraints.maxWidth / 4, // Utiliser la largeur du parent
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImageManager()),
                    );
                  },
                  fillColor: AppColor.secondary,
                  hoverColor: AppColor.tertiary,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Images",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Pixelify Sans",
                          fontWeight: FontWeight.normal,
                          fontSize: 40,
                        ),
                      ),
                      Icon(Icons.image),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width:
                    constraints.maxWidth / 4, // Utiliser la largeur du parent
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: AppColor.secondary,
                  hoverColor: AppColor.tertiary,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Audios",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Pixelify Sans",
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                          )),
                      Icon(Icons.audiotrack),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width:
                    constraints.maxWidth / 4, // Utiliser la largeur du parent
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: AppColor.secondary,
                  hoverColor: AppColor.tertiary,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Fonts",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Pixelify Sans",
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                          )),
                      Icon(Icons.font_download),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

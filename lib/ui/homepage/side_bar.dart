
import 'package:flutter/material.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/services/page_switcher.dart';

class SideBar extends StatelessWidget{
  const SideBar({super.key, required this.changePage});

  final Function(Widget) changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.secondary,
        border: Border(
          top: BorderSide(
            color: AppColor.tertiary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              MaterialButton(
                onPressed: () {
                  changePage(AppPage.mapEditor);
                },
                color: AppColor.secondary,
                textColor: Colors.white,
                hoverColor: AppColor.yellow,
                minWidth: 120,
                child: const Text('Map Editor'),
              ),
              MaterialButton(
                onPressed: () {
                  changePage(AppPage.tilesetEditor);
                },
                color: AppColor.secondary,
                textColor: Colors.white,
                hoverColor: AppColor.yellow,
                minWidth: 120,
                child: const Text('Tileset Editor'),
              ),
              MaterialButton(
                onPressed: () {
                  changePage(AppPage.scriptEditor);
                },
                color: AppColor.secondary,
                textColor: Colors.white,
                hoverColor: AppColor.yellow,
                minWidth: 120,
                child: const Text('Script Editor'),
              ),
              MaterialButton(
                onPressed: () {
                  changePage(AppPage.assetsManager);
                },
                color: AppColor.secondary,
                textColor: Colors.white,
                hoverColor: AppColor.yellow,
                minWidth: 120,
                child: const Text('Assets Manager'),
              )
            ],
          ),
        ],
      ),
    );
  }

}
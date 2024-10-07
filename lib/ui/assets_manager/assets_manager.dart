import 'package:flutter/material.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/ui/assets_manager/category_selection.dart';

class AssetsManager extends StatefulWidget {
  const AssetsManager({super.key});

  @override
  _AssetsManagerState createState() => _AssetsManagerState();
}

class _AssetsManagerState extends State<AssetsManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: CategorySelection(),
    );
  }
}

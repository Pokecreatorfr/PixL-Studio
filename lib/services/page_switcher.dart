

import 'package:flutter/material.dart';
import 'package:pixlstudio/ui/map_editor/map_editor.dart';
import 'package:pixlstudio/ui/tileset_editor/tileset_editor.dart';
import 'package:pixlstudio/ui/script_editor/script_editor.dart';
import 'package:pixlstudio/ui/assets_manager/assets_manager.dart';

class AppPage{
  static const Widget mapEditor = MapEditor();
  static const Widget tilesetEditor = TilesetEditor();
  static const Widget scriptEditor = ScriptEditor();
  static const Widget assetsManager = AssetsManager();
}
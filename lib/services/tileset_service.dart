import 'dart:convert';
import 'dart:io';
import 'project_service.dart';

class TilesetService {
  static final TilesetService _instance = TilesetService._internal();

  TilesetService._internal();

  factory TilesetService() {
    return _instance;
  }

  List<Tileset> tilesets = [];

  void loadTilesets() {
    Directory dir = Directory(ProjectService.tileset_path!);
    List<FileSystemEntity> files = dir.listSync();

    for (FileSystemEntity file in files) {
      if (file.path.endsWith('.json')) {
        String content = File(file.path).readAsStringSync();
        Map<String, dynamic> json = jsonDecode(content);

        Tileset tileset = Tileset(json['path']);

        for (Map<String, dynamic> tile in json['tiles']) {
          tileset.tiles.add(Tile(tile['index'], tile['anim']));
        }

        tilesets.add(tileset);
      }
    }
  }

  void saveTilesets() {
    for (Tileset tileset in tilesets) {
      tileset.save();
    }
  }
}

class Tileset {
  String? name;
  String path;
  String? imagePath;
  int? width;
  int? height;
  int? tileSize;
  List<Tile> tiles = [];

  Tileset(this.path) {
    // open file in json
    String content = File(path).readAsStringSync();
    Map<String, dynamic> json = jsonDecode(content);

    name = json['name'];
    imagePath = json['imagePath'];
    width = json['width'];
    height = json['height'];
    tileSize = json['tileWidth'];

    for (Map<String, dynamic> tile in json['tiles']) {
      tiles.add(Tile(tile['index'], tile['anim']));
    }
  }

  void save() {
    Map<String, dynamic> json = {
      'name': name,
      'width': width,
      'height': height,
      'tileWidth': tileSize,
      'tiles': []
    };

    for (Tile tile in tiles) {
      json['tiles'].add({
        'index': tile.index,
        'anim': tile.anim,
      });
    }

    File file = File(path);
    file.writeAsStringSync(jsonEncode(json));
  }
}

class Tile {
  int index;
  TileAnimation? anim;

  Tile(this.index, this.anim);
}

class TileAnimation {
  int index;
  int speed;
  List<int> frames = [];

  TileAnimation(this.index, this.speed, this.frames);
}

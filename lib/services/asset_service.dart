import 'dart:convert';
import 'dart:io';
import "package:pixlstudio/services/project_service.dart";

class AssetService {
  static final AssetService _instance = AssetService._internal();

  AssetService._internal();

  factory AssetService() {
    return _instance;
  }

  List<Asset> assets = [];

  List<Asset> getAssetsByType(AssetType type) {
    List<Asset> result = [];
    for (Asset asset in assets) {
      if (asset.type == type) {
        result.add(asset);
      }
    }
    return result;
  }

  void loadAssets() {
    assets = [];
    // open file assats.pixl
    String content = File(
            '${ProjectService.path!}/${ProjectService.assets_path!}/assets.pixl')
        .readAsStringSync();
    if (content.isEmpty) {
      return;
    }
    Map<String, dynamic> json = jsonDecode(content);

    for (Map<String, dynamic> asset in json['assets']) {
      assets.add(
          Asset(asset['name'], asset['path'], AssetType.values[asset['type']]));
    }
  }

  void saveAssets() {
    Map<String, dynamic> json = {'assets': []};

    for (Asset asset in assets) {
      json['assets'].add(
          {'name': asset.name, 'path': asset.path, 'type': asset.type.index});
    }

    File('${ProjectService.path!}/${ProjectService.assets_path!}/assets.pixl')
        .writeAsStringSync(jsonEncode(json));
  }

  void addAsset(Asset asset) {
    // check if asset already exists
    for (Asset a in assets) {
      if (a.name == asset.name) {
        return;
      }
    }
    assets.add(asset);
    saveAssets();
  }

  void removeAsset(Asset asset) {
    assets.remove(asset);
    saveAssets();
  }
}

enum AssetType {
  image,
  audio,
  font,
}

class Asset {
  String name;
  String path;
  AssetType type;

  Asset(this.name, this.path, this.type);
}

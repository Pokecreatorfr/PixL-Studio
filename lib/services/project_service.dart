import 'dart:convert';
import 'dart:io';

class ProjectService {
  // Crée une instance statique privée de la classe
  static final ProjectService _instance = ProjectService._internal();

  // Constructeur privé
  ProjectService._internal();

  // Factory constructeur pour renvoyer l'instance unique
  factory ProjectService() {
    return _instance;
  }

  static bool OpenProject(String path) {
    bool exists = Directory(path).existsSync();
    if (!exists) {
      return false;
    }
    // lire le fichier de configuration
    File file = File(path + '/project.pixl');
    if (!file.existsSync()) {
      return false;
    }
    // lire le fichier de configuration en json
    String content = file.readAsStringSync();
    // convertir le json en objet
    Map<String, dynamic> json = jsonDecode(content);
    // récupérer les chemins
    ProjectService.path = path;
    ProjectService.tileset_path = json['tileset directory'];
    ProjectService.script_path = json['script directory'];
    ProjectService.assets_path = json['assets directory'];
    ProjectService.map_path = json['map directory'];

    // vérifier si les dossiers existent
    if (!Directory(path + '/' + ProjectService.tileset_path!).existsSync()) {
      return false;
    }
    if (!Directory(path + '/' + ProjectService.script_path!).existsSync()) {
      return false;
    }
    if (!Directory(path + '/' + ProjectService.assets_path!).existsSync()) {
      return false;
    }
    if (!Directory(path + '/' + ProjectService.map_path!).existsSync()) {
      return false;
    }
    // verifier si le fichier assets / assets.pixl existe
    if (!File(path + '/' + ProjectService.assets_path! + '/assets.pixl')
        .existsSync()) {
      return false;
    }

    return true;
  }

  static String? path;
  static String? tileset_path;
  static String? script_path;
  static String? assets_path;
  static String? map_path;
}

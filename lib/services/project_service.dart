class ProjectService {
  // Crée une instance statique privée de la classe
  static final ProjectService _instance = ProjectService._internal();

  // Constructeur privé
  ProjectService._internal();

  // Factory constructeur pour renvoyer l'instance unique
  factory ProjectService() {
    return _instance;
  }

  static String? path;
}

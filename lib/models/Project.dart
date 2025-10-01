class Project {
  final String title;
  final String desc;
  final DateTime date;
  final ProjectStatus status;

  Project({
    required this.title,
    required this.desc,
    required this.date,
    required this.status,
  });
}

enum ProjectStatus {
  enCours,
  termine,
  aVenir,
}

class Task {
  String title;
  bool completed ;
  List<String>? details;

  Task({required this.title, required this.completed, this.details});

  Task.fromJson(Map<String, dynamic> json):
      this.title = json['title'],
      this.completed = json['completed'],
      this.details = json['details'];
}
class Task {
  final String _name;
  bool _isCompleted;
  List<String> _details = [];

  Task(this._name, {bool isCompleted = false}) : _isCompleted = isCompleted;

  String get name => _name;

  bool get isCompleted => _isCompleted;

  set isCompleted(bool value) {
    _isCompleted = value;
  }

  List<String> get details => _details;

  static Task fromJson(Map<String, dynamic> json) {
    return Task(json['title'], isCompleted: json['completed']);
  }

  void addDetail(String detail) {
    _details.add(detail);
  }
}

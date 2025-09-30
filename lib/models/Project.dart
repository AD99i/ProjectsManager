class Project{
  String _title= "";
  String _desc = "";
  Project(this._title, this._desc);

  String get title => _title;
  String get desc => _desc;

  void set title(String newTitle){
    _title = newTitle;
  }

  void set desc(String newDesc){
    _desc = newDesc;
  }
}
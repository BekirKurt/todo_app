class Todos {
  int id;
  String title;
  String description;
  String category;
  bool isDone;

  Todos(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.category});

  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setDesc(String newDesc) {
    description = newDesc;
  }

  void setCategory(String newCategory) {
    category = newCategory;
  }
}

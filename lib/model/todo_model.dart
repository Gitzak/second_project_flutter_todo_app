class TodoModel {
  String? id;
  String? todoText;
  bool isDone;

  TodoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<TodoModel> todoList() {
    return [
      TodoModel(id: '1', todoText: 'Make exercices', isDone: true),
      TodoModel(id: '2', todoText: 'Learn Flutter', isDone: true),
      TodoModel(id: '3', todoText: 'Go to gym'),
      TodoModel(id: '4', todoText: 'coffee time'),
      TodoModel(id: '6', todoText: 'Friday Morning'),
      TodoModel(id: '7', todoText: 'Friday Morning'),
      TodoModel(id: '8', todoText: 'Friday Morning'),
    ];
  }
}

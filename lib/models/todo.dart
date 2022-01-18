class Todo {
  final int
    userId,
    id;
  final String title;
  final bool completed;

  Todo(
    this.userId,
    this.id,
    this.title,
    this.completed
  );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }

  @override
  String toString() {
    return 'Todo{userId: $userId, id: $id, title: $title, completed: $completed}';
  }
}
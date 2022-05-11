class Todo {
  int id;
  int user_id;
  final String status;
  final String title;
  final String description;

  Todo({required this.id, required this.title, required this.description,required this.status,required this.user_id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],user_id: json['user_id'], title: json['title'], description: json['due_on'],status: json['status']);
  }
  dynamic toJson() => {'id': id,'user_id': user_id,'status': status, 'title': title, 'due_on': description};
}

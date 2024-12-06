class TodoListModel {
  final int id;
  final String title;
  final String date;
  final bool isComplete;

  TodoListModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isComplete,
  });

  TodoListModel copyWith({
    int? id,
    String? title,
    String? date,
    bool? isComplete,
  }) =>
      TodoListModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete,
      );

  @override
  int get hashCode {
    return id;
  }

}

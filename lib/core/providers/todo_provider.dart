import 'package:flutter/cupertino.dart';
import 'package:todos/core/models/todo.dart';
import 'package:todos/core/services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  TodoService _service = TodoService();

  Stream<List<Todo>> fetchAllTodoAsStream() {
    return _service.todos();
  }

  Future<void> addNewTodo(Todo todo) {
    return _service.addNewTodo(todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    return _service.deleteTodo(todo);
  }

  Future<void> updateTodo(Todo todo) {
    return _service.updateTodo(todo);
  }
}

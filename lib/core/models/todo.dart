import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:todos/core/services/auth_service.dart';
import 'package:todos/locator.dart';

@immutable
class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  AuthService _auth = locator<AuthService>();

  Todo(this.title,
      {this.isCompleted = false, String description = '', String id})
      : this.description = description ?? '',
        this.id = id;

  Todo copyWith(
      {bool isComplete, String id, String title, String description}) {
    return Todo(
      description ?? this.description,
      isCompleted: isComplete ?? this.isCompleted,
      id: id ?? this.id,
      description: title ?? this.title,
    );
  }

  @override
  int get hashCode =>
      isCompleted.hashCode ^
      description.hashCode ^
      title.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          isCompleted == other.isCompleted &&
          description == other.description &&
          title == other.title &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $isCompleted, task: $description, note: $title, id: $id}';
  }

  Map<String, Object> toDocument() {
    return {
      'uid': _auth.getUserId(),
      'isComplete': isCompleted,
      'description': description,
      'title': title,
    };
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  static Todo fromSnapshot(DocumentSnapshot snap) {
    return Todo(
      snap.data()['title'],
      id: snap.id,
      description: snap.data()['description'],
      isCompleted: snap.data()['isCompleted'],
    );
  }

  static Todo fromJson(Map<String, Object> json) {
    return Todo(
      json['title'] as String,
      id: json['id'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}

import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
/// A repository that handles todo related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({
    required this.todosApi,
  });

  final TodosApi todosApi;

  /// Provides a [Stream] of all todos.
  Stream<List<Todo>> getTodos() => todosApi.getTodos();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Todo todo) => todosApi.saveTodo(todo);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted() => todosApi.clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted}) =>
      todosApi.completeAll(isCompleted: isCompleted);
}

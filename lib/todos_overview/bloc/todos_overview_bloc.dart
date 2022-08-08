import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/todos_overview/todos_overview.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_overview_event.dart';

part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc() : super(const TodosOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
    on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
    _initRepo();
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);


    on<TodosOverviewDeleteAllRequested>(_onDeleteAllRequested);
  }

  late TodosRepository _todosRepository;

  void _initRepo() async {
    _todosRepository = TodosRepository(todosApi: LocalStorageTodosApi(plugin: await SharedPreferences.getInstance()));
  }

  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    // TODO
  }

  Future<void> _onTodoCompletionToggled(
    TodosOverviewTodoCompletionToggled event,
    Emitter<TodosOverviewState> emit,
  ) async {
    // TODO
  }

  void _onFilterChanged(
    TodosOverviewFilterChanged event,
    Emitter<TodosOverviewState> emit,
  ) {
    // TODO
  }

  Future<void> _onToggleAllRequested(
    TodosOverviewToggleAllRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    // TODO
  }

  Future<void> _onClearCompletedRequested(
    TodosOverviewClearCompletedRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    // TODO
  }

  Future<void> _onDeleteAllRequested(
      TodosOverviewDeleteAllRequested event,
      Emitter<TodosOverviewState> emit,
      ) async {
    var api = _todosRepository.todosApi;
    await api.deleteAll();
  }

  Future<void> _onTodoDeleted(
      TodosOverviewTodoDeleted event,
      Emitter<TodosOverviewState> emit,
      ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    var api = _todosRepository.todosApi;
    await api.deleteTodo(event.todo.id);
  }
}

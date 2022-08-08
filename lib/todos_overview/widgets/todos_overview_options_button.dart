import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/todos_overview/todos_overview.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted, deleteAll }

class TodosOverviewOptionsButton extends StatelessWidget {
  const TodosOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.select((TodosOverviewBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodosOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: 'Options',
      onSelected: (options) {
        switch (options) {
          case TodosOverviewOption.toggleAll:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewToggleAllRequested());
            break;
          case TodosOverviewOption.clearCompleted:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewClearCompletedRequested());
            break;
          case TodosOverviewOption.deleteAll:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewDeleteAllRequested());
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosOverviewOption.toggleAll,
            enabled: hasTodos,
            child: Text(
              completedTodosAmount == todos.length
                  ? "Mark all as incomplete"
                  : "Mark all as completed",
            ),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.clearCompleted,
            enabled: hasTodos && completedTodosAmount > 0,
            child: Text("Clear completed"),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.deleteAll,
            enabled: hasTodos,
            child: Container(
              child: Text(
                "Delete All",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}

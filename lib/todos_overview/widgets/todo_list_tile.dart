import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.todo,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.caption?.color;

    return Container(
        alignment: Alignment.centerRight,
        color: Colors.grey[500],
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
            onTap: onTap,
            title: Text(
              todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: !todo.isCompleted
                  ? null
                  : TextStyle(
                      color: captionColor,
                      decoration: TextDecoration.lineThrough,
                    ),
            ),
            subtitle: Container(
              decoration: BoxDecoration(color: Colors.amber),
              child: Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            leading: Checkbox(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              value: todo.isCompleted,
              onChanged: onToggleCompleted == null
                  ? null
                  : (value) => onToggleCompleted!(value!),
            ),
            trailing: onTap == null ? null : const Icon(Icons.chevron_right)));
  }
}

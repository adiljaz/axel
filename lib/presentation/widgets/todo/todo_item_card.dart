// presentation/widgets/todo/todo_item_card.dart
import 'package:flutter/material.dart';
import '../../../domain/entities/todo.dart';

class TodoItemCard extends StatelessWidget {
  final Todo todo;
  final Function(int) onFavoriteToggle;

  const TodoItemCard({
    super.key,
    required this.todo,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: todo.completed
              ? Colors.green.withOpacity(0.2)
              : Colors.orange.withOpacity(0.2),
          child: Icon(
            todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: todo.completed ? Colors.green : Colors.orange,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            fontWeight: todo.completed ? FontWeight.normal : FontWeight.w500,
          ),
        ),
        subtitle: Text(
          todo.completed ? 'Completed' : 'Pending',
          style: TextStyle(
            color: todo.completed ? Colors.green : Colors.orange,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            todo.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: todo.isFavorite ? Colors.red : null,
          ),
          onPressed: () => onFavoriteToggle(todo.id),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
    final Todo todo;
    final onDone;
    final onDelete;

    const TodoItem({
        Key? key, 
        required this.todo,
        required this.onDone,
        required this.onDelete,
        }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
                onTap: () {
                    onDone(todo);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                tileColor: Colors.white,
                leading: Icon(todo.done? Icons.check_box : Icons.check_box_outline_blank, color: blue),
                title: Text(todo.text!, style: TextStyle(fontSize: 16, color: black, decoration: todo.done? TextDecoration.lineThrough : null)),
                trailing: Container(
                    height: 35, 
                    width: 35, 
                    decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(5)),
                    child: IconButton(color: Colors.white, iconSize: 18, icon: Icon(Icons.delete), onPressed: () {
                        onDelete(todo.id);
                    })
                ),
            )
        );
    }
}
import 'package:flutter/material.dart';

class Todo {
    int id;
    String? text;
    bool done;

    Todo({
        required this.id,
        required this.text,
        this.done = false,
    });

    static List<Todo> todoList() {
        return [
            Todo(id: 1, text: 'Shopping', done: true),
            Todo(id: 2, text: 'Gaming', done: true),
            Todo(id: 3, text: 'Dinner'),
            Todo(id: 4, text: 'Mail'),
            Todo(id: 5, text: 'Walk'),
        ];
    }
}
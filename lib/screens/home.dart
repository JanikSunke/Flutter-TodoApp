import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
    Home({Key? key}) : super(key: key);

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    final todoList = Todo.todoList();
    final _todoController = TextEditingController();

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
            backgroundColor: transparent,
            title: Text(
                'Todo App',
                style: TextStyle(color: blue))),
        body: Stack(
                children: [
                    Container(
                        child: ListView(
                            children: [
                                Container(
                                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                    child: Text('Todo List:', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
                                ),
                                for (Todo todo in todoList) 
                                    TodoItem(
                                        todo: todo,
                                        onTodoChanged: _handleToDoChange,
                                        onDeleteItem: _deleteTodoItem,
                                    ),
                            ]
                        )
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(children: [
                            Expanded(child: Container(
                                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                    controller: _todoController,
                                    decoration: InputDecoration(
                                        hintText: 'Add your item',
                                        border: InputBorder.none,
                                    ),
                                ),
                            )),
                            Container(
                                margin: EdgeInsets.only(bottom: 20, right: 20),
                                child: ElevatedButton(
                                    child: Text('+', style: TextStyle(fontSize: 40,)),
                                    onPressed: () {
                                        _addTodoElement(_todoController.text);
                                    },
                                ),
                            )
                        ])
                    )
                ]
            )
        );
    }

    void _handleToDoChange(Todo todo) {
        setState(() {
            todo.done = !todo.done;
        });
    }

    void _deleteTodoItem(int id) {
        setState(() {
            todoList.removeWhere((item) => item.id == id);
        });
    }

    void _addTodoElement(String todo) {
        setState(() {
            todoList.add(Todo(id: todoList.last.id + 1, text: todo));
        });
        _todoController.clear(); //Clear text field
    }

}


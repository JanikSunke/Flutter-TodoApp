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
    final todoList1 = Todo.todoList();
    final _todoController = TextEditingController();
    int currentPageIndex = 0;

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
            backgroundColor: darkBlue,
            title: Text(
                'Todo App',
                style: TextStyle(color: Colors.white))),
            bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                    setState(() {
                        currentPageIndex = index;
                    });
                },
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                    NavigationDestination(
                        selectedIcon: Icon(Icons.home),
                        icon: Icon(Icons.home_outlined),
                        label: 'Home',
                    ),
                    NavigationDestination(
                        selectedIcon: Icon(Icons.check_circle),
                        icon: Icon(Icons.check_circle_outlined),
                        label: 'Todo',
                    ),
                    NavigationDestination(
                        selectedIcon: Icon(Icons.playlist_add_check_circle),
                        icon: Icon(Icons.playlist_add_check_circle_outlined),
                        label: 'Done',
                    ),
                ],
        ),
        body: <Widget>[
                Container(
                alignment: Alignment.center,
                child: welcome(),
                ),
                Container(
                alignment: Alignment.center,
                child: list(),
                ),
                Container(
                alignment: Alignment.center,
                child: doneList(),
                ),
            ][currentPageIndex],
        );
    }

    Widget welcome() {
        return Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(Icons.check_circle, size: 150, color: blue),
                    Text('Welcome', style: TextStyle(fontSize: 72, fontWeight: FontWeight.w700)),
                    Text('Go check out the todo app:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                    GestureDetector(
                        onTap: () {
                            setState(() {
                            currentPageIndex = 1;
                            });
                        },
                        child: Container(
                            decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.all(20),
                            padding: const EdgeInsets.all(8),
                            child: Text("Go to your Todo"),
                        ),
                    ),
                    GestureDetector(
                        onTap: () {
                            setState(() {
                            currentPageIndex = 2;
                            });
                        },
                        child: Container(
                            decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.all(20),
                            padding: const EdgeInsets.all(8),
                            child: Text("Go to your finished Todo"),
                        ),
                    ),
                ],
            ),
        );
    }

    Widget doneList() {
        return Container(
            child: ListView(
                children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                        child: Text('Done List:', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
                    ),
                    for (Todo todo in todoList1) 
                        if (todo.done) 
                            TodoItem(
                                todo: todo,
                                onTodoChanged: _handleChange,
                                onDeleteItem: _handleDelete,
                            ),    
                ]
            )
        );
    }

    Widget list() {
        return Stack(
                children: [
                    Container(
                        child: ListView(
                            children: [
                                Container(
                                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                    child: Text('Todo List:', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
                                ),
                                for (Todo todo in todoList1) 
                                    if (!todo.done)
                                    TodoItem(
                                        todo: todo,
                                        onTodoChanged: _handleChange,
                                        onDeleteItem: _handleDelete,
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
                                        _handleAdd(_todoController.text);
                                    },
                                ),
                            )
                        ])
                    )
                ]
            );
    }

    void _handleChange(Todo todo) {
        setState(() {
            todo.done = !todo.done;
        });
    }

    void _handleDelete(int id) {
        setState(() {
            todoList1.removeWhere((item) => item.id == id);
        });
    }

    void _handleAdd(String todo) {
        setState(() {
            todoList1.add(Todo(id: todoList1.last.id + 1, text: todo));
        });
        _todoController.clear(); //Clear text field
    }

}


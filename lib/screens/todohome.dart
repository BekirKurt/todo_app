import 'package:flutter/material.dart';
import 'package:todo_app/models/todos.dart';
import 'package:todo_app/widgets/list_todos.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  late List<Todos> toDosList = [
    Todos(
        id: 0,
        title: "delectus aut autem",
        description:
            "laboriosam mollitia et enim quasi adipisci quia provident illum",
        isDone: false,
        category: "personal"),
    Todos(
        id: 1,
        title: "fugiat veniam minus",
        description: "et itaque necessitatibus maxime molestiae qui quas velit",
        isDone: true,
        category: "work"),
  ];
  String filter = 'all';
  @override
  Widget build(BuildContext context) {
    TextEditingController todoTitleController = TextEditingController();
    TextEditingController todoDescController = TextEditingController();
    TextEditingController todoCategoryController = TextEditingController();

    List<Todos> getFilteredList() {
      switch (filter) {
        case 'all':
          return toDosList;
        case 'completed':
          return toDosList.where((todo) => todo.isDone).toList();
        case 'uncompleted':
          return toDosList.where((todo) => !todo.isDone).toList();
        default:
          return toDosList;
      }
    }

    List<Todos> filteredList = getFilteredList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF424042),
        title: const Text("ToDo App"),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showFilterMenu(context);
              }),
          PopupMenuButton<String>(
            offset: const Offset(-22, 40),
            onSelected: (String result) {
              setState(() {
                if (result == "item2") {
                  if (true) {
                    _showAlertDialog(
                        context, "Are you sure delete all task", false);
                  }
                } else if (result == "item1") {
                  var length = toDosList.length;
                  for (var i = 0; i < length; i++) {
                    toDosList[i].isDone = true;
                  }
                } else {
                  // print("Error..");
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'item1',
                child: Text('Select all'),
              ),
              const PopupMenuItem<String>(
                value: 'item2',
                child: Text('Clear all'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        color: const Color(0xFF2F2D2F),
        child: Center(
          child: ListTodos(toDosList: filteredList),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF739072),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Add new todo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: todoTitleController,
                          decoration: const InputDecoration(
                            hintText: 'title',
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                          controller: todoDescController,
                          decoration: const InputDecoration(
                            hintText: 'description',
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                          controller: todoCategoryController,
                          decoration: const InputDecoration(
                            hintText: 'category',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            String todo = todoTitleController.text;
                            if (todo != "") {
                              setState(() {
                                int currentIndex = toDosList.length;

                                toDosList.add(Todos(
                                    id: currentIndex,
                                    title: todoTitleController.text,
                                    description: todoDescController.text,
                                    isDone: false,
                                    category:
                                        todoCategoryController.text.isEmpty
                                            ? "Empty"
                                            : todoCategoryController.text));
                              });
                              Navigator.pop(context);
                            } else {
                              _showAlertDialog(context,
                                  "Empty task can't not be added", true);
                            }
                          },
                          child: const Text('Add Task'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add, size: 36),
        ),
      ),
    );
  }

  void showFilterMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(120.0, 90.0, 180.0, 0.0),
      items: [
        const PopupMenuItem(
          value: 'all',
          child: Text('Show all'),
        ),
        const PopupMenuItem(
          value: 'completed',
          child: Text('Show completed'),
        ),
        const PopupMenuItem(
          value: 'uncompleted',
          child: Text('Show uncompleted'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          filter = value;
        });
      }
    });
  }

  void _showAlertDialog(
      BuildContext context, String message, bool cancelOption) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2F2D2F),
          title: const Text('Warning',
              style: TextStyle(color: Colors.white, fontSize: 22)),
          content: Text(message, style: const TextStyle(color: Colors.white)),
          actions: [
            cancelOption
                ? const SizedBox.shrink()
                : TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                        toDosList.clear();
                      });
                    },
                    child:
                        const Text('OK', style: TextStyle(color: Colors.white)),
                  ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(cancelOption ? "OK" : 'Cancel',
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

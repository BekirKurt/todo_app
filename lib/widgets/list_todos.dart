import 'package:flutter/material.dart';
import 'package:todo_app/models/todos.dart';
import 'package:todo_app/screens/detail_todos.dart';

class ListTodos extends StatefulWidget {
  final List<Todos> toDosList;

  const ListTodos({super.key, required this.toDosList});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  @override
  Widget build(BuildContext context) {
    return widget.toDosList.isEmpty
        ? const Text("List is empty",
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold))
        : ListView.builder(
            itemCount: widget.toDosList.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: const BoxDecoration(
                    color: Color(0xFF424042),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTodo(
                            toDo: widget.toDosList[index],
                            updateList: updateList,
                          ),
                        ),
                      );
                    },
                    title: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Checkbox(
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            value: widget.toDosList[index].isDone,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.toDosList[index].isDone = value!;
                              });
                            }),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.toDosList[index].title} (${widget.toDosList[index].category})",
                                softWrap: true,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(widget.toDosList[index].description,
                                  softWrap: true,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        )
                      ]),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _showAlertDialog(context, index);
                        });
                      },
                      icon: Icon(Icons.delete,
                          color: Colors.red.shade400, size: 28),
                    ),
                  ),
                ),
              );
            },
          );
  }

  void updateList() {
    setState(() {
      widget.toDosList;
    });
  }

  void _showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2F2D2F),
          title: const Text('Warning',
              style: TextStyle(color: Colors.white, fontSize: 22)),
          content: const Text('Are you sure delete this item?',
              style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.toDosList.removeAt(index);
                  Navigator.of(context).pop();
                });
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

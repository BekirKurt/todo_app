import 'package:flutter/material.dart';
import 'package:todo_app/models/todos.dart';

class DetailTodo extends StatefulWidget {
  final Todos toDo;
  final Function() updateList;
  const DetailTodo({super.key, required this.toDo, required this.updateList});

  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  late TextEditingController todoDescController;
  late TextEditingController todoTitleController;
  late TextEditingController todoCategoryController;

  @override
  void initState() {
    super.initState();

    todoDescController = TextEditingController(text: widget.toDo.description);
    todoTitleController = TextEditingController(text: widget.toDo.title);
    todoCategoryController = TextEditingController(text: widget.toDo.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424042),
        title: const Text("Detail and update "),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              TextField(
                controller: todoTitleController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: todoCategoryController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: todoDescController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                maxLines: 6,
              ),
              ElevatedButton(
                  onPressed: () {
                    String formattedTitle = todoTitleController.text;
                    String formattedDesc = todoDescController.text;
                    String formattedCategory = todoCategoryController.text;
                    // print('Entered text: $formattedTitle');

                    // Girilen değeri güncelleyin
                    setState(() {
                      todoTitleController.text = formattedTitle;
                      todoDescController.text = formattedDesc;
                      todoCategoryController.text = formattedCategory;
                      widget.toDo.setTitle(formattedTitle);
                      widget.toDo.setDesc(formattedDesc);
                      widget.toDo.setCategory(formattedCategory);
                      widget.updateList();
                    });

                    showSnackBar(context, 'Todo updated successfully');
                  },
                  child: const Text("Update"))
            ],
          ),
        )),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(30),
        content: Text(message),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

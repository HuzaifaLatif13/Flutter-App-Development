import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class ToDoListScreen extends StatelessWidget {
  ToDoListScreen({super.key});
  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController textcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => ListView.builder(
            itemCount: controller.todos.length,
            itemBuilder: (context, index) {
              var todo = controller.todos[index];
              return GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "ToDo Details",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          todo.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          todo.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    confirm: ElevatedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Close"),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amberAccent, width: 1),
                  ),
                  child: ListTile(
                    title: Text(todo.title),
                    leading: Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.amberAccent,
                        value: todo.isComplete.value,
                        onChanged: (value) => controller.onComplete(todo.id)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => controller.onFavourite(todo.id),
                          icon: Icon(
                            todo.isFavourite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: todo.isFavourite.value
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        IconButton(
                            onPressed: () => controller.deleteToDo(todo.id),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
            contentPadding: const EdgeInsets.all(15),
            titlePadding: const EdgeInsets.only(top: 15),
            title: "Add ToDo",
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titlecontroller,
                  decoration: const InputDecoration(hintText: "Enter title..."),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: textcontroller,
                  maxLines: 2,
                  decoration:
                      const InputDecoration(hintText: "Enter description..."),
                ),
              ],
            ),
            confirm: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
              onPressed: () {
                if (titlecontroller.text.isNotEmpty &&
                    textcontroller.text.isNotEmpty) {
                  controller.addToDo(titlecontroller.text, textcontroller.text);
                  titlecontroller.clear();
                  textcontroller.clear();
                  Get.back();
                }
              },
              child: const Text("Add"),
            ),
            cancel: TextButton(
                onPressed: () => Get.back(), child: const Text("Cancel")),
          );
        },
      ),
    );
  }
}

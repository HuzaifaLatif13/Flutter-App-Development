import 'package:get/get.dart';
import 'package:todo_app/models/todo.dart';

class ToDoController extends GetxController {
  var todos = <todo>[].obs;

  void addToDo(String title, String description) {
    int newId = todos.isEmpty ? 1 : todos.last.id + 1;
    todos.add(todo(id: newId, title: title, description: description));
  }

  void onComplete(int id) {
    var todo = todos.firstWhere((todo) => todo.id == id);
    todo.isComplete.value = !todo.isComplete.value;
    todos.refresh();
  }

  void onFavourite(int id) {
    var todo = todos.firstWhere((todo) => todo.id == id);
    todo.isFavourite.value = !todo.isFavourite.value;
    todos.refresh();
  }

  void deleteToDo(int id) {
    todos.removeWhere((todo) => todo.id == id);
    todos.refresh();
  }

  List<todo> getFav() {
    return todos.where((todo) => todo.isFavourite == true).toList();
  }
}

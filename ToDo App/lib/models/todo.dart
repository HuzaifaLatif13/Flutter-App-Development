import 'package:get/get.dart';

class todo {
  int id;
  String title;
  String description;
  RxBool isComplete;
  RxBool isFavourite;

  todo(
      {required this.id,
      required this.title,
      required this.description,
      bool isComplete = false,
      bool isFavourite = false})
      : isComplete = isComplete.obs,
        isFavourite = isFavourite.obs;

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isComplete": isComplete.value,
      "isFavourite": isFavourite.value,
    };
  }

  factory todo.fromJSON(Map<String, dynamic> json) {
    return todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isComplete: json["isComplete"],
        isFavourite: json["isFavourite"]);
  }
}

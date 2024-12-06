import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/tab_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/data/model/todo_model/todo_list_model.dart';

class TodoController extends ChangeNotifier {

  late TabController tabController;

  final List<TodoListModel> _todoItems = [];

  var todoTextController = TextEditingController();

  List<TodoListModel> get completeList =>
      _todoItems.where((item) => item.isComplete == true).toList();

  List<TodoListModel> get unCompleteList => _todoItems
      .where((item) => item.isComplete == false)
      .toList();

  GlobalKey<ScaffoldState> scafoldState=GlobalKey<ScaffoldState>();

  //check is uncomplete list empty
  bool get isUnCompleteListEmpty => unCompleteList.length==0;
  //check is complete list empty
  bool get isCompleteListEmpty => completeList.length==0;


  void addTodo() {
    if (todoTextController.text.isNotEmpty) {
      _todoItems.add(TodoListModel(
          id: _todoItems.length + 1,
          title: todoTextController.text[0].toUpperCase() + todoTextController.text.substring(1),
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          isComplete: false));
      todoTextController.clear();
      showMessage(text: "New Task has been added");
      notifyListeners();
    }
  }


  // we are finding the index of all listitem where this uncomplete item index.
  void onTodoComplete({required int index}) {
    int indexOfUncompleteListItem=  _todoItems.indexOf(unCompleteList[index]);
    _todoItems[indexOfUncompleteListItem]=  _todoItems[indexOfUncompleteListItem].copyWith(isComplete: true);
    print( _todoItems[indexOfUncompleteListItem].isComplete);
    showMessage(text: "Task Completed");

    notifyListeners();
  }
  void onTodoBackToUncomplete({required int index}) {
    int indexOfCompleteListItem=  _todoItems.indexOf(completeList[index]);
    _todoItems[indexOfCompleteListItem]=  _todoItems[indexOfCompleteListItem].copyWith(isComplete: false);
    print( _todoItems[indexOfCompleteListItem].isComplete);

    showMessage(text: "Task back to Active Todo ");
    notifyListeners();
  }

  // use to show snackbar
  void showMessage({required String text}){
    ScaffoldMessenger.of(scafoldState.currentContext!).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
      ),
    );
  }


}

final todoProvider = ChangeNotifierProvider((ref) => TodoController());

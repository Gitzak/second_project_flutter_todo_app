import 'package:flutter/material.dart';
import 'package:second_project_flutter_todo_app/constants/colors.dart';
import 'package:second_project_flutter_todo_app/model/todo_model.dart';
import 'package:second_project_flutter_todo_app/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = TodoModel.todoList();
  final _todoController = TextEditingController();
  List<TodoModel> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: const Text(
                        "My ToDos",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 50,
                      ),
                      child: Column(
                        children: [
                          for (TodoModel todo in _foundTodo.reversed)
                            TodoWidget(
                              todo: todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteTodoItem,
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new todo',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: const Size(35, 35),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _runFilter(String entredKeyword) {
    List<TodoModel> results = [];
    if (entredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(entredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      todoList.add(
        TodoModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

  void _handleToDoChange(TodoModel todoModel) {
    setState(() {
      todoModel.isDone = !todoModel.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              child: Image.asset(
                  'assets/images/avatar_avocado_food_scream_icon.png'),
            ),
          ),
        ],
      ),
    );
  }
}

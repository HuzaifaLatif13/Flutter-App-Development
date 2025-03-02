import 'package:flutter/material.dart';
import 'package:todo_app/screens/ToDoListScreen.dart';
import 'package:todo_app/screens/FavListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  final List<Widget> _screens = [
    ToDoListScreen(),
    FavListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("ToDo App"),
        backgroundColor: Colors.amberAccent,
      ),
      body: SafeArea(child: _screens[_selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.amberAccent,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.view_list_rounded),
            icon: Icon(Icons.view_list_outlined),
            label: "ToDos",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border_outlined),
            label: "Favourite",
          ),
        ],
        onTap: (index) => setState(() => _selectedTab = index),
      ),
    );
  }
}

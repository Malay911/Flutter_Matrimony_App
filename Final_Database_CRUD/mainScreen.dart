import 'package:flutter/material.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _todos = [];
  List<Map<String, dynamic>> _filteredTodos = [];

  @override
  void initState() {
    super.initState();
    dbHelper.open();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    _todos = await dbHelper.getAllTodos();
    _filterTodos();
  }

  void _filterTodos() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _filteredTodos = _todos
          .where((todo) => todo['title'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo CRUD')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Add Todo'),
                ),
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search by Title',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => _filterTodos(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = _filteredTodos[index];
                return ListTile(
                  title: Text(todo['title']),
                  subtitle: Text(todo['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditDialog(todo),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTodo(todo['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTodo() async {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      await dbHelper.addTodo(_titleController.text, _descriptionController.text);
      _titleController.clear();
      _descriptionController.clear();
      await _loadTodos();
    }
  }

  Future<void> _deleteTodo(int id) async {
    await dbHelper.deleteTodo(id);
    await _loadTodos();
  }

  void _showEditDialog(Map<String, dynamic> todo) {
    _titleController.text = todo['title'];
    _descriptionController.text = todo['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await dbHelper.updateTodo(
                todo['id'],
                _titleController.text,
                _descriptionController.text,
              );
              _titleController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
              await _loadTodos();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    dbHelper.close();
    _titleController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
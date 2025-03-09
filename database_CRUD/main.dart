import 'package:flutter/material.dart';
import 'user.dart';
import 'database_helper.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PersonListPage(),
    );
  }
}

class PersonListPage extends StatefulWidget {
  const PersonListPage({super.key});

  @override
  State<PersonListPage> createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  late Future<List<Person>> _personList;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _personList = DatabaseHelper.instance.getAllPersons();
    });
  }

  Future<void> _showFormDialog({Person? person}) async {
    final nameController = TextEditingController(text: person?.name);
    final ageController = TextEditingController(text: person?.age?.toString());
    final cityController = TextEditingController(text: person?.city);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(person == null ? 'Add Person' : 'Edit Person'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(person == null ? 'Add' : 'Update'),
              ),
            ],
          ),
    );

    if (result == true) {
      final name = nameController.text.trim();
      final city = cityController.text.trim();

      if (name.isNotEmpty && city.isNotEmpty && ageController.text.isNotEmpty) {
        final age = int.tryParse(ageController.text.trim());
        if (age != null) {
          if (person == null) {
            await DatabaseHelper.instance.insert(
              Person(name: name, age: age, city: city),
            );
          } else {
            await DatabaseHelper.instance.update(
              Person(id: person.id, name: name, age: age, city: city),
            );
          }
          _refreshList();
        }
      }
    }

    if (mounted) {
      nameController.dispose();
      ageController.dispose();
      cityController.dispose();
    }
  }

  Future<void> _deletePerson(int id) async {
    try {
      await DatabaseHelper.instance.delete(id);
      _refreshList();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Person deleted successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      body: FutureBuilder<List<Person>>(
        future: _personList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final person = snapshot.data![index];
              return ListTile(
                title: Text(person.name),
                subtitle: Text('Age: ${person.age} | City: ${person.city}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showFormDialog(person: person),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deletePerson(person.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

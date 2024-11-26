import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({super.key});

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Children List'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by name',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text.toLowerCase();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Map<String, dynamic>>('children').listenable(),
        builder: (context, Box<Map<String, dynamic>> box, _) {
          final List<Map<String, dynamic>> filteredChildren = box.values
              .where((child) => child['name']
                  .toLowerCase()
                  .contains(_searchQuery)) // Filter by search query
              .toList();

          if (filteredChildren.isEmpty) {
            return const Center(child: Text('No matching children found.'));
          }

          return ListView.builder(
            itemCount: filteredChildren.length,
            itemBuilder: (context, index) {
              final child = filteredChildren[index];
              final List<dynamic> vaccines = child['vaccineDetails'] ?? [];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(child['name']),
                  subtitle: Text(
                    'Birthdate: ${DateTime.parse(child['birthdate']).toLocal().toString().split(' ')[0]}',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vaccines.length,
                      itemBuilder: (context, vaccineIndex) {
                        final vaccine = vaccines[vaccineIndex];
                        return ListTile(
                          title: Text('Vaccine: ${vaccine['type']}'),
                          subtitle: Text('Doses: ${vaccine['doses']}'),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _addVaccine(context, box, index),
                      child: const Text('Add Vaccine'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addVaccine(BuildContext context, Box<Map<String, dynamic>> box, int index) {
    final TextEditingController vaccineTypeController = TextEditingController();
    final TextEditingController doseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Vaccine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vaccineTypeController,
                decoration: const InputDecoration(labelText: 'Vaccine Type'),
              ),
              TextField(
                controller: doseController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of Doses'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (vaccineTypeController.text.isNotEmpty &&
                    doseController.text.isNotEmpty &&
                    int.tryParse(doseController.text) != null) {
                  final child = box.getAt(index)!;
                  final List<dynamic> vaccineDetails =
                      List.from(child['vaccineDetails'] ?? []);

                  vaccineDetails.add({
                    'type': vaccineTypeController.text,
                    'doses': int.parse(doseController.text),
                  });

                  final updatedChild = {
                    'name': child['name'],
                    'birthdate': child['birthdate'],
                    'vaccineDetails': vaccineDetails,
                  };

                  box.putAt(index, updatedChild);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vaccine added successfully!')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

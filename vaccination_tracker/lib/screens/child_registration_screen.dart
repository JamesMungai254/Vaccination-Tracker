import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChildRegistrationScreen extends StatefulWidget {
  const ChildRegistrationScreen({super.key});

  @override
  State<ChildRegistrationScreen> createState() =>
      _ChildRegistrationScreenState();
}

class _ChildRegistrationScreenState extends State<ChildRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vaccineTypeController = TextEditingController();
  final _vaccineCountController = TextEditingController();
  DateTime? _selectedBirthdate;

  // Add child data to Hive
  Future<void> _addChild() async {
    if (_formKey.currentState!.validate()) {
      final childrenBox = Hive.box<Map<String, dynamic>>('children');
      await childrenBox.add({
        'name': _nameController.text,
        'birthdate': _selectedBirthdate!.toIso8601String(),
        'vaccineType': _vaccineTypeController.text,
        'vaccineCount': int.parse(_vaccineCountController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Child registered successfully!')),
      );

      // Clear inputs
      _nameController.clear();
      _vaccineTypeController.clear();
      _vaccineCountController.clear();
      setState(() {
        _selectedBirthdate = null;
      });
    }
  }

  // Display a date picker
  Future<void> _pickBirthdate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedBirthdate) {
      setState(() {
        _selectedBirthdate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Child')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Child's Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Child Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the child\'s name' : null,
              ),
              const SizedBox(height: 16),

              // Birthdate Picker
              ListTile(
                title: Text(
                  _selectedBirthdate == null
                      ? 'Select Birthdate'
                      : 'Birthdate: ${_selectedBirthdate!.toLocal()}'
                          .split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickBirthdate(context),
              ),
              const SizedBox(height: 16),

              // Vaccine Type
              TextFormField(
                controller: _vaccineTypeController,
                decoration:
                    const InputDecoration(labelText: 'Type of Vaccine'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the vaccine type' : null,
              ),
              const SizedBox(height: 16),

              // Number of Vaccines Administered
              TextFormField(
                controller: _vaccineCountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Number of Times Vaccine Administered'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of times';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Register Button
              ElevatedButton(
                onPressed: _addChild,
                child: const Text('Register Child'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

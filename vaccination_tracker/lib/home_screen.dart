import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '/screens/child_registration_screen.dart';
import '/screens/children_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vaccination Tracker'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.add), text: 'Register Child'),
              Tab(icon: Icon(Icons.list), text: 'Children List'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChildRegistrationScreen(),
            ChildrenListScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAboutDialog(context);
          },
          tooltip: 'About',
          child: const Icon(Icons.info),
        ),
      ),
    );
  }

  /// Show an about dialog with application details
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Vaccination Tracker',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.vaccines),
      children: [
        const Text(
          'This application helps you track children\'s vaccinations. '
          'You can register children, add vaccination details, and view a list of registered children.',
        ),
      ],
    );
  }
}

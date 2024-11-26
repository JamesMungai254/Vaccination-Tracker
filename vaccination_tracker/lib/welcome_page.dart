import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '/screens/child_registration_screen.dart';
import '/screens/children_list_screen.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Tracker'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChildrenListScreen(),
                ),
              );
            },
            child: const Text(
              'Go to Children List',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Image
            Image.asset(
              'assets/vaccinationImg.webp', // Ensure this image exists in assets
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Vaccination Tracker App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This app helps you track children\'s vaccinations, register new children, and manage vaccination records efficiently.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Navigation Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChildRegistrationScreen(),
                  ),
                );
              },
              child: const Text('Register Child'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChildrenListScreen(),
                  ),
                );
              },
              child: const Text('View Children List'),
            ),
          ],
        ),
      ),
    );
  }
}

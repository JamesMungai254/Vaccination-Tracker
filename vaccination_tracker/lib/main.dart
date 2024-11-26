import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'home_screen.dart';
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes
  await Hive.openBox<Map<String, dynamic>>('children');
  await Hive.openBox<Map<String, dynamic>>('vaccinations');

  runApp(const VaccinationTrackerApp());
}
class VaccinationTrackerApp extends StatelessWidget {
  const VaccinationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaccination Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomePage(), // HomeScreen with navigation
    );
  }
}


import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static late Box<Map<String, dynamic>> _childrenBox;
  static late Box<Map<String, dynamic>> _vaccinationsBox;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  /// Initialize Hive and open boxes
  Future<void> initialize() async {
    // Open the children and vaccinations boxes
    _childrenBox = await Hive.openBox<Map<String, dynamic>>('children');
    _vaccinationsBox = await Hive.openBox<Map<String, dynamic>>('vaccinations');
  }

  /// Add a child to the `children` box
  Future<void> addChild(String name, String birthdate) async {
    await _childrenBox.add({'name': name, 'birthdate': birthdate});
  }

  /// Get all children from the `children` box
  List<Map<String, dynamic>> getChildren() {
    return _childrenBox.values.toList();
  }

  /// Add a vaccination to the `vaccinations` box
  Future<void> addVaccination(int childId, String vaccineType, int doseNumber) async {
    await _vaccinationsBox.add({
      'child_id': childId,
      'vaccine_type': vaccineType,
      'dose_number': doseNumber,
    });
  }

  /// Get all vaccinations for a specific child
  List<Map<String, dynamic>> getVaccinations(int childId) {
    return _vaccinationsBox.values
        .where((vaccination) => vaccination['child_id'] == childId)
        .toList();
  }
}

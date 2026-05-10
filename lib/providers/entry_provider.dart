import 'package:flutter/foundation.dart' hide Category;
import 'package:uuid/uuid.dart';
import '../models/entry.dart';
import '../services/database_service.dart';

class EntriesNotifier extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Entry> _allEntries = [];
  Category? _selectedCategory;
  final Map<Category, int> _categoryCounts = {};

  List<Entry> get allEntries => _allEntries;
  Category? get selectedCategory => _selectedCategory;

  List<Entry> get filteredEntries {
    if (_selectedCategory == null) {
      return _allEntries;
    }
    return _allEntries
        .where((entry) => entry.category == _selectedCategory)
        .toList();
  }

  int getCategoryCount(Category category) {
    return _categoryCounts[category] ?? 0;
  }

  int get totalCount => _allEntries.length;

  EntriesNotifier() {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    _allEntries = await _dbService.getAllEntries();
    // Sort by date descending (newest first)
    _allEntries.sort((a, b) => b.createdDate.compareTo(a.createdDate));

    // Calculate counts for each category
    for (var category in Category.values) {
      _categoryCounts[category] = _allEntries
          .where((e) => e.category == category)
          .length;
    }

    notifyListeners();
  }

  Future<void> createEntry({
    required String title,
    required String content,
    required Category category,
  }) async {
    const uuid = Uuid();
    final entry = Entry(
      id: uuid.v4(),
      title: title,
      content: content,
      category: category,
      createdDate: DateTime.now(),
    );

    await _dbService.createEntry(entry);
    await _loadEntries();
  }

  Future<void> updateEntry({
    required String id,
    required String title,
    required String content,
    required Category category,
  }) async {
    final entry = Entry(
      id: id,
      title: title,
      content: content,
      category: category,
      createdDate: DateTime.now(),
    );

    await _dbService.updateEntry(entry);
    await _loadEntries();
  }

  Future<void> deleteEntry(String id) async {
    await _dbService.deleteEntry(id);
    await _loadEntries();
  }

  void setSelectedCategory(Category? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

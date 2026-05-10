import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  static const String tableName = 'entries';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnCategory = 'category';
  static const String columnCreatedDate = 'createdDate';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'life_tapestry.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnContent TEXT NOT NULL,
            $columnCategory TEXT NOT NULL,
            $columnCreatedDate TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Create a new entry
  Future<void> createEntry(Entry entry) async {
    final db = await database;
    await db.insert(
      tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all entries
  Future<List<Entry>> getAllEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => Entry.fromMap(maps[i]));
  }

  // Get entries by category
  Future<List<Entry>> getEntriesByCategory(Category category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnCategory = ?',
      whereArgs: [category.toShortString()],
    );
    return List.generate(maps.length, (i) => Entry.fromMap(maps[i]));
  }

  // Get entry count by category
  Future<int> getEntryCategoryCount(Category category) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName WHERE $columnCategory = ?',
      [category.toShortString()],
    );
    return int.parse(result.first['count'].toString());
  }

  // Get total entry count
  Future<int> getTotalEntryCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName',
    );
    return int.parse(result.first['count'].toString());
  }

  // Update an entry
  Future<void> updateEntry(Entry entry) async {
    final db = await database;
    await db.update(
      tableName,
      entry.toMap(),
      where: '$columnId = ?',
      whereArgs: [entry.id],
    );
  }

  // Delete an entry
  Future<void> deleteEntry(String id) async {
    final db = await database;
    await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  // Clear all entries (for testing)
  Future<void> clearAllEntries() async {
    final db = await database;
    await db.delete(tableName);
  }
}

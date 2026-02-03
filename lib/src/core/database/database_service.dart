import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sahsiyet.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // User Profile Table
    await db.execute('''
      CREATE TABLE user_profile (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        full_name TEXT,
        email TEXT,
        created_at TEXT NOT NULL,
        level INTEGER DEFAULT 1,
        experience_points INTEGER DEFAULT 0,
        total_tasks_completed INTEGER DEFAULT 0,
        current_streak INTEGER DEFAULT 0,
        longest_streak INTEGER DEFAULT 0,
        unlocked_badges TEXT,
        notifications_enabled INTEGER DEFAULT 1,
        theme_mode TEXT DEFAULT 'dark',
        language TEXT DEFAULT 'tr'
      )
    ''');

    // Tasks Table
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id TEXT UNIQUE NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        created_at TEXT NOT NULL,
        completed_at TEXT,
        is_completed INTEGER DEFAULT 0,
        is_locked INTEGER DEFAULT 0,
        experience_reward INTEGER DEFAULT 10,
        priority INTEGER DEFAULT 1
      )
    ''');

    // Library Content Table
    await db.execute('''
      CREATE TABLE library_content (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content_id TEXT UNIQUE NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        category TEXT NOT NULL,
        reference TEXT,
        transliteration TEXT,
        translation TEXT,
        tags TEXT,
        created_at TEXT NOT NULL,
        is_favorite INTEGER DEFAULT 0,
        view_count INTEGER DEFAULT 0
      )
    ''');

    // Chat History Table
    await db.execute('''
      CREATE TABLE chat_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        message_id TEXT UNIQUE NOT NULL,
        text TEXT NOT NULL,
        is_user INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');

    // Progress Table
    await db.execute('''
      CREATE TABLE progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        tasks_completed INTEGER DEFAULT 0,
        experience_gained INTEGER DEFAULT 0,
        prayers_performed INTEGER DEFAULT 0,
        dua_read INTEGER DEFAULT 0,
        content_viewed INTEGER DEFAULT 0,
        streak_maintained INTEGER DEFAULT 0,
        UNIQUE(date)
      )
    ''');

    // Badges Table
    await db.execute('''
      CREATE TABLE badges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        badge_id TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        icon_name TEXT NOT NULL,
        category TEXT NOT NULL,
        required_value INTEGER NOT NULL,
        requirement_type TEXT NOT NULL,
        rarity TEXT NOT NULL,
        is_unlocked INTEGER DEFAULT 0,
        unlocked_at TEXT
      )
    ''');

    // Create default user profile
    await db.insert('user_profile', {
      'id': 1,
      'username': 'Kullanıcı',
      'created_at': DateTime.now().toIso8601String(),
      'unlocked_badges': '[]',
    });
  }

  // User Profile Operations
  static Future<Map<String, dynamic>?> getUserProfile() async {
    final db = await database;
    final result = await db.query('user_profile', limit: 1);
    if (result.isEmpty) return null;
    
    final profile = Map<String, dynamic>.from(result.first);
    profile['unlocked_badges'] = jsonDecode(profile['unlocked_badges'] ?? '[]');
    return profile;
  }

  static Future<void> updateUserProfile(Map<String, dynamic> profile) async {
    final db = await database;
    if (profile.containsKey('unlocked_badges')) {
      profile['unlocked_badges'] = jsonEncode(profile['unlocked_badges']);
    }
    await db.update('user_profile', profile, where: 'id = 1');
  }

  // Task Operations
  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    return await db.query('tasks', orderBy: 'created_at DESC');
  }

  static Future<List<Map<String, dynamic>>> getActiveTasks() async {
    final db = await database;
    return await db.query('tasks',
        where: 'is_completed = 0', orderBy: 'priority DESC');
  }

  static Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    return await db.insert('tasks', task);
  }

  static Future<void> updateTask(String taskId, Map<String, dynamic> task) async {
    final db = await database;
    await db.update('tasks', task, where: 'task_id = ?', whereArgs: [taskId]);
  }

  static Future<void> deleteTask(String taskId) async {
    final db = await database;
    await db.delete('tasks', where: 'task_id = ?', whereArgs: [taskId]);
  }

  // Library Content Operations
  static Future<List<Map<String, dynamic>>> getAllLibraryContent() async {
    final db = await database;
    final results = await db.query('library_content', orderBy: 'created_at DESC');
    return results.map((item) {
      final parsed = Map<String, dynamic>.from(item);
      parsed['tags'] = jsonDecode(parsed['tags'] ?? '[]');
      return parsed;
    }).toList();
  }

  static Future<List<Map<String, dynamic>>> getLibraryContentByCategory(
      String category) async {
    final db = await database;
    final results = await db.query('library_content',
        where: 'category = ?', whereArgs: [category]);
    return results.map((item) {
      final parsed = Map<String, dynamic>.from(item);
      parsed['tags'] = jsonDecode(parsed['tags'] ?? '[]');
      return parsed;
    }).toList();
  }

  static Future<int> insertLibraryContent(Map<String, dynamic> content) async {
    final db = await database;
    if (content.containsKey('tags')) {
      content['tags'] = jsonEncode(content['tags']);
    }
    return await db.insert('library_content', content);
  }

  static Future<void> toggleFavorite(String contentId, bool isFavorite) async {
    final db = await database;
    await db.update(
      'library_content',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'content_id = ?',
      whereArgs: [contentId],
    );
  }

  // Chat History Operations
  static Future<List<Map<String, dynamic>>> getAllChatHistory() async {
    final db = await database;
    return await db.query('chat_history', orderBy: 'timestamp ASC');
  }

  static Future<int> insertChatMessage(Map<String, dynamic> message) async {
    final db = await database;
    return await db.insert('chat_history', message);
  }

  static Future<void> clearChatHistory() async {
    final db = await database;
    await db.delete('chat_history');
  }

  // Progress Operations
  static Future<Map<String, dynamic>?> getTodayProgress() async {
    final db = await database;
    final today = DateTime.now().toIso8601String().split('T')[0];
    final result = await db.query('progress',
        where: 'date = ?', whereArgs: [today], limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> insertProgress(Map<String, dynamic> progress) async {
    final db = await database;
    return await db.insert('progress', progress,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getProgressRange(
      String startDate, String endDate) async {
    final db = await database;
    return await db.query('progress',
        where: 'date BETWEEN ? AND ?',
        whereArgs: [startDate, endDate],
        orderBy: 'date DESC');
  }

  // Badge Operations
  static Future<List<Map<String, dynamic>>> getAllBadges() async {
    final db = await database;
    return await db.query('badges');
  }

  static Future<List<Map<String, dynamic>>> getUnlockedBadges() async {
    final db = await database;
    return await db.query('badges', where: 'is_unlocked = 1');
  }

  static Future<int> insertBadge(Map<String, dynamic> badge) async {
    final db = await database;
    return await db.insert('badges', badge);
  }

  static Future<void> unlockBadge(String badgeId) async {
    final db = await database;
    await db.update(
      'badges',
      {
        'is_unlocked': 1,
        'unlocked_at': DateTime.now().toIso8601String(),
      },
      where: 'badge_id = ?',
      whereArgs: [badgeId],
    );
  }
}

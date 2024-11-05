import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _transactionDatabase;
  static Database? _savedItemsDatabase;

  static Future<Database> getTransactionDatabase() async {
    if (_transactionDatabase != null) return _transactionDatabase!;
    _transactionDatabase = await _initTransactionDatabase();
    return _transactionDatabase!;
  }

  static Future<Database> getSavedItemsDatabase() async {
    if (_savedItemsDatabase != null) return _savedItemsDatabase!;
    _savedItemsDatabase = await _initSavedItemsDatabase();
    return _savedItemsDatabase!;
  }

  static Future<Database> _initTransactionDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'wallet_transactions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            label TEXT,
            isTopUp INTEGER,
            date TEXT
          )
        ''');
      },
    );
  }

  static Future<Database> _initSavedItemsDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'saved_items.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE saved_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            label TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  // Fungsi-fungsi terkait transaksi
  static Future<void> addTransaction(double amount, String label, bool isTopUp) async {
    final db = await getTransactionDatabase();
    await db.insert('transactions', {
      'amount': amount,
      'label': label,
      'isTopUp': isTopUp ? 1 : 0,
      'date': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> removeTransaction(int id) async {
    final db = await getTransactionDatabase();
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await getTransactionDatabase();
    return await db.query('transactions', orderBy: 'date DESC');
  }

  // Fungsi-fungsi terkait item yang disimpan
  static Future<void> saveItem(double amount, String label) async {
    final db = await getSavedItemsDatabase();
    await db.insert('saved_items', {
      'amount': amount,
      'label': label,
      'date': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> getSavedItems() async {
    final db = await getSavedItemsDatabase();
    return await db.query('saved_items', orderBy: 'date DESC');
  }

  static Future<void> removeSavedItem(int id) async {
    final db = await getSavedItemsDatabase();
    await db.delete('saved_items', where: 'id = ?', whereArgs: [id]);
  }
}

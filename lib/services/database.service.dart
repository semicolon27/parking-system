import 'dart:io';

import 'package:parking_system/models/karcis.model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    print('INFO: DATABASE INITIALIZED');
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databaseFactory = databaseFactoryFfi;
    String dir = Directory.current.path; // PATH_APP

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    var db = await databaseFactory.openDatabase(
      "$dir/database.db",
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
        onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      ),
    );
    return db;
  }

  // When the database is first created, create a table to store tipe_kendaraan
  // and a table to store karcis.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {tipe_kendaraan} TABLE statement on the database.
    await db.execute(
      '''CREATE TABLE karcis(
          id_karcis TEXT PRIMARY KEY, 
          plat_nomor TEXT, 
          id_tipe_kendaraan TEXT,
          is_bayar INTEGER,
          waktu_masuk TEXT,
          waktu_keluar TEXT
        )''',
    );
    // Run the CREATE {karcis} TABLE statement on the database.
    await db.execute(
      '''CREATE TABLE tipe_kendaraan(
          id_tipe_kendaraan TEXT PRIMARY KEY,
          nama_tipe_kendaraan TEXT,
          harga_awal INTEGER,
          harga_perjam INTEGER
        )''',
    );
    // INSERT INITIAL DATA INTO TIPE_KENDARAAN
    await db.execute(
      '''INSERT INTO tipe_kendaraan VALUES
        ('A1', 'Motor', '5000', '2000'),
        ('B1', 'Mobil', '10000', '3000')
      ''',
    );
  }

  Future<void> buatKarcisMasuk(Karcis karcis) async {
    final db = await _databaseService.database;
    await db.rawQuery('INSERT INTO karcis VALUES (?, ?, ?, ?, ?, "")', [
      karcis.idKarcis,
      karcis.platNomor,
      karcis.idTipeKendaraan,
      karcis.isBayar ? 1 : 0,
      karcis.waktuMasuk,
    ]);
  }

  Future<void> bayarParkir(Karcis karcis) async {
    final db = await _databaseService.database;
    await db.rawQuery(
        'UPDATE karcis SET is_bayar = ?, waktu_keluar = ? WHERE id_karcis = ?',
        [
          karcis.isBayar ? 1 : 0,
          karcis.waktuKeluar,
          karcis.idKarcis,
        ]);
  }

  Future<Karcis> getDataKarcis(String idKarcis) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("""SELECT * FROM karcis 
          INNER JOIN tipe_kendaraan ON karcis.id_tipe_kendaraan = karcis.id_tipe_kendaraan
          WHERE id_karcis = ?""", [idKarcis]);
    return Karcis.fromMap(maps[0]);
  }

  Future<List<Karcis>> getListDataKarcis() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("""SELECT * FROM karcis 
          INNER JOIN tipe_kendaraan ON karcis.id_tipe_kendaraan = tipe_kendaraan.id_tipe_kendaraan""");
    return List.generate(maps.length, (index) => Karcis.fromMap(maps[index]));
  }
}

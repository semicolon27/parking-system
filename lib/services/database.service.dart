import 'dart:io';

import 'package:parking_system/models/karcis.model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class Service {
  Future<Database> _initDatabase();
  Future<void> _onCreate(Database db, int version);
  Future<void> buatKarcisMasuk(Karcis karcis);
  Future<void> bayarParkir(Karcis karcis);
  Future<Karcis> getDataKarcis(String idKarcis);
  Future<List<Karcis>> getListDataKarcis();
}

class DatabaseService implements Service {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  // berisi koneksi database
  static Database? _database;
  // getter variabel database.
  // ketika akan mengambil variabel database, maka akan melakukan pengecekan terlebih dahulu
  // apakah database null atau tidak.
  // jika null maka akan memanggil fungsi _initDatabase() untuk mendapatkan koneksi database
  // dan disimpan ke variabel database
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    print('INFO: DATABASE INITIALIZED');
    return _database!;
  }

  // untuk mendapatkan koneksi database
  @override
  Future<Database> _initDatabase() async {
    var databaseFactory = databaseFactoryFfi;
    String dir = Directory.current.path; // PATH_APP

    var db = await databaseFactory.openDatabase(
      // lokasi database. jika di mobile maka akan disimpan sesuai konfigurasi dari package databasenya yaitu di variable inMemoryDatabasePath
      // kalau desktop "$dir/database.db" itu ada di folder project
      Platform.isAndroid ? inMemoryDatabasePath : "$dir/database.db",
      options: OpenDatabaseOptions(
        // ketika datbase tidak ada maka akan memanggil fungsi _onCreate
        onCreate: _onCreate,
        // ketika aplikasi di jalankan, dan database akan di cek versinya dengan di app.
        //jika versinya sama di db dan app maka tidak akan membuat ulang database
        version: 1,
        // mengaktifkan fitur foreign_keys untuk join table
        onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      ),
    );
    return db;
  }

  // Wfungsi yang di jalankan apabila database dibuat
  // membuat tabel untuk karcis dan tipe kendaraan
  // dan menginsert default value tipe kendaraan
  @override
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

  // insert karcis baru
  @override
  Future<void> buatKarcisMasuk(Karcis karcis) async {
    final db = await _databaseService.database;
    await db.rawQuery("INSERT INTO karcis VALUES (?, ?, ?, ?, ?, '')", [
      karcis.idKarcis,
      karcis.platNomor,
      karcis.idTipeKendaraan,
      karcis.isBayar ? 1 : 0,
      karcis.waktuMasuk,
    ]);
  }

  // mengupdate karcis bayar menjadi 1 (true) atau sudah bayar yang sebelumnya 0 (false) atau belum bayar
  @override
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

  // mndapatkan detail karcis berdasarkan id nya
  @override
  Future<Karcis> getDataKarcis(String idKarcis) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("""SELECT * FROM karcis 
          INNER JOIN tipe_kendaraan ON karcis.id_tipe_kendaraan = tipe_kendaraan.id_tipe_kendaraan
          WHERE id_karcis = ?""", [idKarcis]);
    return Karcis.fromMap(maps[0]);
  }

  // mendapatkan semua list karcis
  @override
  Future<List<Karcis>> getListDataKarcis() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("""SELECT * FROM karcis 
          INNER JOIN tipe_kendaraan ON karcis.id_tipe_kendaraan = tipe_kendaraan.id_tipe_kendaraan""");
    return List.generate(maps.length, (index) => Karcis.fromMap(maps[index]));
  }
}

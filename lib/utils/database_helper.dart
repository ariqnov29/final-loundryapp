import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:laundryapl/model/noteOrder.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String customerTable = 'customer';
  String csId = 'id';
  String csnama = 'nama';
  String cshp = 'hp';
  String csemail = 'email';
  String csalamat = 'alamat';

  String transaksiTable = 'transaksi';
  String trId = 'id';
  String trcs = 'idcs';
  String trtglpesan = 'tglpesan';
  String trtglselesai = 'tglselesai';
  String trpengiriman = 'pengiriman';
  String trtregular = 'regular';
  String trhelm = 'helm';
  String trselimut = 'selimut';
  String trkarpet = 'karpet';
  String trtotalbayar = 'bayar';
  String trstatus = 'status';

  // String noteTable = 'note_table';
  // String colId = 'id';
  // String colStatus = 'status';
  // String colTipe = 'tipe';
  // String colNama = 'nama';
  // String colJumlah = 'jumlah';
  // String colHarga = 'harga';
  // String colDate = 'date';

  DatabaseHelper._createInstance(); // constructor untuk instance DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Mencari directory path Android and iOS untuk store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create database
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $customerTable($csId INTEGER PRIMARY KEY AUTOINCREMENT, $csnama VARCHAR(50) NULL, $cshp VARCHAR(15) NULL, $csemail VARCHAR(50) NULL, $csalamat TEXT)');
    await db.execute(
        'CREATE TABLE $transaksiTable($trId INTEGER PRIMARY KEY AUTOINCREMENT, $trcs INT, $trtglpesan DATETIME NULL ,$trtglselesai DATETIME NULL, $trpengiriman VARCHAR(20) NULL, $trtregular INT DEFAULT 0 NULL,$trhelm INT DEFAULT 0 NULL,$trselimut INT DEFAULT 0 NULL,$trkarpet INT DEFAULT 0 NULL, $trtotalbayar INT DEFAULT 0 NULL, $trstatus INT)');
  }

  // Read customer
  Future<List<Map<String, dynamic>>> getNoteCustomerList() async {
    Database db = await this.database;

    var result = await db.query(customerTable, orderBy: '$csId ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTransactionDetail() async {
    Database db = await this.database;

    List<Map<String, dynamic>> result =
        await db.query(transaksiTable, orderBy: '$trId ASC');

    List<Map<String, dynamic>> listtransactiondetail = [];

    await Future.forEach(result, (trx) async {
      List<Map<String, dynamic>> customer = await db.query(customerTable,
          where: "id = ?", whereArgs: [trx["idcs"]], orderBy: '$csId ASC');
      print("csdetail");
      print(customer);

      await Future.forEach(customer, (cs) async {
        Map<String, dynamic> transactiondetail = {};
        print("jalan-jalan");
        transactiondetail["id"] = trx["id"];
        transactiondetail["idcs"] = trx["idcs"];
        transactiondetail["tglpesan"] = trx["tglpesan"];
        transactiondetail["tglselesai"] = trx["tglselesai"];
        transactiondetail["pengiriman"] = trx["pengiriman"];
        transactiondetail["regular"] = trx["regular"];
        transactiondetail["helm"] = trx["helm"];
        transactiondetail["selimut"] = trx["selimut"];
        transactiondetail["karpet"] = trx["karpet"];
        transactiondetail["bayar"] = trx["bayar"];
        transactiondetail["status"] = trx["status"];
        transactiondetail["selimut"] = trx["selimut"];
        transactiondetail["csnama"] = cs["nama"];
        transactiondetail["cshp"] = cs["hp"];
        transactiondetail["csemail"] = cs["email"];
        transactiondetail["csalamat"] = cs["alamat"];
        print("bawah!");
        print(transactiondetail);
        listtransactiondetail.add(transactiondetail);
      });
    });

    print("kosong");
    print(listtransactiondetail);
    return listtransactiondetail;
  }

  // Insert database
  Future<int> insertCustomer(Map<String, dynamic> customer) async {
    Database db = await this.database;
    var result = await db.insert(customerTable, customer);
    return result;
  }

  Future<int> insertTransaksi(Map<String, dynamic> transaksi) async {
    Database db = await this.database;
    var result = await db.insert(transaksiTable, transaksi);
    return result;
  }

  Future<int> updateTransaksi(Map<String, dynamic> transaksi) async {
    Database db = await this.database;
    var result = await db.update(transaksiTable, transaksi);
    return result;
  }

  // Update database
  // Future<int> updateNote(Note note) async {
  //   var db = await this.database;
  //   var result = await db.update(noteTable, note.toMap(),
  //       where: '$colId = ?', whereArgs: [note.id]);
  //   return result;
  // }

  // Delete database
  // Future<int> deleteNote(int id) async {
  //   var db = await this.database;
  //   int result =
  //       await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
  //   return result;
  // }

  // Get number Note objects di database
  // Future<int> getCount() async {
  //   Database db = await this.database;
  //   List<Map<String, dynamic>> x =
  //       await db.rawQuery('SELECT COUNT (*) from $noteTable');
  //   int result = Sqflite.firstIntValue(x);
  //   return result;
  // }

  // Get 'Map List' [ List<Map> ] dan convert ke 'Note List' [ List<Note> ]
  // Future<List<Note>> getNoteList() async {
  //   var noteMapList = await getNoteMapList();
  //   int count = noteMapList.length;

  //   List<Note> noteList = List<Note>();
  //   // For loop untuk create 'Note List' dari 'Map List'
  //   for (int i = 0; i < count; i++) {
  //     noteList.add(Note.fromMapObject(noteMapList[i]));
  //   }

  //   return noteList;
  // }

  // //SUMHarga
  // Future getTotal() async {
  //   var dbClient = await this.database;
  //   var result =
  //       await dbClient.rawQuery("SELECT SUM($colHarga) FROM $noteTable");
  //   double value = result[0]["SUM($colHarga)"]; // value = 220
  //   return value.round().toString();
  // }
}

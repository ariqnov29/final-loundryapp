import 'package:flutter/material.dart';
import 'package:laundryapl/model/noteOrder.dart';
import 'package:laundryapl/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Laporan extends StatefulWidget {
  const Laporan();
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  String penghasilan = "";
  DatabaseHelper databaseHelper = DatabaseHelper();
  int totalorder;
  int totalpenghasilan;
  _LaporanState() {
    retrivedata();
  }

  void retrivedata() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    await dbFuture.then((database) async {
      List<Map<String, dynamic>> ordersdb =
          await databaseHelper.getTransactionDetail();

      int totalp = 0;
      await Future.forEach(ordersdb, (x) async {
        totalp = totalp + x["bayar"];
      });

      setState(() {
        totalorder = ordersdb.length;
        totalpenghasilan = totalp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.white),
            title: Center(
                child: Text(
              'Jumlah Order Hari Ini',
              style: TextStyle(color: Colors.white),
            )),
            subtitle: Center(
              child: Text(
                "$totalorder order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.white),
            title: Center(
                child: Text(
              'Total Penghasilan Hari Ini',
              style: TextStyle(color: Colors.white),
            )),
            subtitle: Center(
              child: Text(
                "Rp. $totalpenghasilan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laundryapl/transaksi.dart';
import 'dart:async';
import 'package:laundryapl/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Transaction extends StatelessWidget {
  final String id;
  final String nama;
  final String status;
  final String tanggal;
  final String total;

  Transaction(this.id, this.nama, this.status, this.tanggal, this.total);

  @override
  Widget build(BuildContext context) {
    String statusname = "";

    if (status == "1") statusname = "Pending";
    if (status == "2") statusname = "Pickup";
    if (status == "3") statusname = "Proses Cuci";
    if (status == "4") statusname = "Dikirim";
    if (status == "5") statusname = "Selesai";

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Transaksi(int.parse(id))));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: Colors.black))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 70,
                  color: Colors.blue,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "#" + id,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                ),
                Align(alignment: Alignment.centerLeft, child: Text(nama))
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Status Order"),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      statusname,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(tanggal),
                Text("Rp. " + total)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> orders = [];
  _OrderState() {
    retrivedata();
  }
  void retrivedata() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    await dbFuture.then((database) async {
      List<Map<String, dynamic>> ordersdb =
          await databaseHelper.getTransactionDetail();
      setState(() {
        orders = ordersdb;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(orders);
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext ctxt, int index) => Transaction(
                orders[index]["id"].toString(),
                orders[index]["csnama"],
                orders[index]["status"].toString(),
                orders[index]["tglpesan"],
                orders[index]["bayar"].toString())),
      ),
    );
  }
}

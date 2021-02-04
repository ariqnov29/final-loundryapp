import 'package:flutter/material.dart';
import 'package:laundryapl/model/noteOrder.dart';
import 'package:laundryapl/notaDetail.dart';
import 'package:laundryapl/utils/database_helper.dart';
import 'package:laundryapl/parts/step.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:laundryapl/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Transaksi extends StatefulWidget {
  final int id;
  Transaksi(this.id);

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  DatabaseHelper helper = DatabaseHelper();

  int statusheader = 1;
  String pengiriman = "";
  int idcs;
  String tanggalorder = "";
  String tanggalselesai = "";
  String alamat = "";
  String kasir = "Demo Kasir";
  int regular = 0;
  int helm = 0;
  int selimut = 0;
  int karpet = 0;
  String nama = "";
  String telepon = "";
  String total = "";

  DatabaseHelper databaseHelper = DatabaseHelper();
  _OrderState() {
    retrivedata();
    if (statusheader == 1)
      status = "Pending";
    else if (statusheader == 2)
      status = "Pickup";
    else if (statusheader == 3)
      status = "Proses Cuci";
    else if (statusheader == 4)
      status = "Dikirim";
    else if (statusheader == 5) status = "Selesai";
  }

  _TransaksiState() {
    retrivedata();
  }

  void retrivedata() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    await dbFuture.then((database) async {
      List<Map<String, dynamic>> ordersdb =
          await databaseHelper.getTransactionDetail();
      setState(() {
        statusheader = ordersdb[widget.id - 1]["status"];
        pengiriman = ordersdb[widget.id - 1]["pengiriman"];
        tanggalorder = ordersdb[widget.id - 1]["tglpesan"];
        tanggalselesai = ordersdb[widget.id - 1]["tglselesai"];
        total = ordersdb[widget.id - 1]["bayar"].toString();
        regular = ordersdb[widget.id - 1]["regular"];
        helm = ordersdb[widget.id - 1]["helm"];
        selimut = ordersdb[widget.id - 1]["selimut"];
        karpet = ordersdb[widget.id - 1]["karpet"];
        idcs = ordersdb[widget.id - 1]["idcs"];
        nama = ordersdb[widget.id - 1]["csnama"];
        telepon = ordersdb[widget.id - 1]["cshp"];
        alamat = ordersdb[widget.id - 1]["csalamat"];
      });
    });
  }

  String status;
  Map<int, String> liststatus = {
    1: "Pending",
    2: "Pickup",
    3: "Proses Cuci",
    4: "Dikirim",
    5: "Selesai"
  };

  String kirim;
  Map<int, String> listpengiriman = {1: "Ambil Sendiri", 2: "Diantar ke Rumah"};

  TextEditingController namaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            StepStatus(statusheader),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ubah Status",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 175,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                              hint: Text("Status Transaksi"),
                              value: status,
                              items: liststatus
                                  .map((key, value) {
                                    return MapEntry(
                                        value,
                                        DropdownMenuItem<String>(
                                          child: Text(value),
                                          value: key.toString(),
                                        ));
                                  })
                                  .values
                                  .toList(),
                              onChanged: (valueselected) {
                                setState(() {
                                  status = valueselected;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pilih Pengiriman",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 175,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                              hint: Text("Metode Pengiriman"),
                              value: kirim,
                              items: listpengiriman
                                  .map((key, value) {
                                    return MapEntry(
                                        value,
                                        DropdownMenuItem<String>(
                                          child: Text(value),
                                          value: key.toString(),
                                        ));
                                  })
                                  .values
                                  .toList(),
                              onChanged: (valueselected) {
                                setState(() {
                                  kirim = valueselected;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      statusheader == 1
                          ? RaisedButton(
                              child: Text(
                                "Cetak Nota",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailNota(
                                            widget.id.toString(),
                                            tanggalorder,
                                            nama,
                                            regular,
                                            helm,
                                            selimut,
                                            karpet,
                                            int.parse(total))));
                              })
                          : Container(),
                      RaisedButton(
                          child: Text(
                            "Simpan",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () async {
                            Map<String, dynamic> transaksibaru = {
                              "idcs": idcs,
                              "tglpesan": tanggalorder,
                              "tglselesai": status == "5"
                                  ? DateFormat("yyyy-MM-dd HH:mm:ss")
                                      .format(DateTime.now())
                                  : null,
                              "status": status
                            };

                            final Future<Database> dbFuture =
                                databaseHelper.initializeDatabase();

                            await dbFuture.then((database) async {
                              await databaseHelper
                                  .updateTransaksi(transaksibaru);
                            });
                          }),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Order ID",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Tanggal Order",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Tanggal Selesai",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Alamat",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Kasir",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Telepon",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Total Bayar",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              "Status Order",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ": #" + widget.id.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": $tanggalorder",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": $tanggalselesai",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": $alamat",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": Aplikasi Kasir",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": $telepon",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": Rp. $total",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                            Text(
                              ": " + liststatus[statusheader],
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}

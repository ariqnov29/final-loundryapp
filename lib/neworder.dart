import 'package:flutter/material.dart';
import 'package:laundryapl/customer.dart';
import 'package:laundryapl/order.dart';
import 'package:laundryapl/transaksi.dart';
import 'package:laundryapl/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  String namacustomer;
  Map<int, String> listcutomer = {};

  final regularjumlahcontroller = TextEditingController();
  final helmjumlahcontroller = TextEditingController();
  final karpetjumlahcontroller = TextEditingController();
  final selimutjumlahcontroller = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  _NewOrderState() {
    listrefresh();
  }

  void listrefresh() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) async {
      Future<List<Map<String, dynamic>>> customerListFuture =
          databaseHelper.getNoteCustomerList();
      Map<int, String> newcustomerlist = {};
      int i = 0;
      await customerListFuture.then((customer) {
        customer.forEach((cs) {
          i++;
          newcustomerlist[i] = cs["id"].toString() +
              " - " +
              cs["nama"].toString() +
              " - " +
              cs["hp"].toString();
        });
      });

      setState(() {
        listcutomer = newcustomerlist;
        print(listcutomer);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView(children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Customer()));
                    },
                    child: Text("Tambah Customer")),
                RaisedButton(
                    onPressed: () {
                      listrefresh();
                    },
                    child: Text("Refresh Customer")),
                Container(
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Pilih Customer"),
                      value: namacustomer,
                      items: listcutomer
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
                          namacustomer = valueselected;
                        });
                      }),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Regular Kiloan",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  color: Colors.white,
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Masukan Kg berat Cucian"),
                    controller: regularjumlahcontroller,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {},
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Helm",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  color: Colors.white,
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Masukan Jumlah Helm"),
                    controller: helmjumlahcontroller,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {},
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selimut",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  color: Colors.white,
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Masukan Jumlah Selimut"),
                    controller: selimutjumlahcontroller,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {},
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Karpet",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  color: Colors.white,
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Masukan Jumlah Karpet"),
                    controller: karpetjumlahcontroller,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {},
                  ),
                ),
                RaisedButton(
                    onPressed: () {
                      // set up the buttons

                      bool regulerx = regularjumlahcontroller.text.isNotEmpty
                          ? int.parse(regularjumlahcontroller.text) > 0
                              ? true
                              : false
                          : false;
                      bool helmx = helmjumlahcontroller.text.isNotEmpty
                          ? int.parse(helmjumlahcontroller.text) > 0
                              ? true
                              : false
                          : false;
                      bool selimutx = selimutjumlahcontroller.text.isNotEmpty
                          ? int.parse(selimutjumlahcontroller.text) > 0
                              ? true
                              : false
                          : false;
                      bool karpetx = karpetjumlahcontroller.text.isNotEmpty
                          ? int.parse(karpetjumlahcontroller.text) > 0
                              ? true
                              : false
                          : false;

                      if (!(regulerx || helmx || selimutx || karpetx)) {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  title: Text("pesanan kosong"),
                                  content: Text(
                                      "Salah Satu Cucian Harus Harus Diisi"),
                                ));
                        return;
                      } else if (namacustomer == null) {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  title: Text("customer kosong"),
                                  content: Text("Customer harus diisi"),
                                ));
                        return;
                      }

                      int totalregular = regulerx
                          ? 7000 * int.parse(regularjumlahcontroller.text)
                          : 0;
                      int totalhelm = helmx
                          ? 15000 * int.parse(helmjumlahcontroller.text)
                          : 0;
                      int totalselimut = selimutx
                          ? 5000 * int.parse(selimutjumlahcontroller.text)
                          : 0;
                      int totalkarpet = karpetx
                          ? 9000 * int.parse(karpetjumlahcontroller.text)
                          : 0;

                      int totalbayar =
                          totalregular + totalhelm + totalselimut + totalkarpet;

                      Widget continueButton = FlatButton(
                        child: Text("Simpan"),
                        onPressed: () async {
                          final Future<Database> dbFuture =
                              databaseHelper.initializeDatabase();

                          Map<String, dynamic> transaksibaru = {
                            "idcs": namacustomer,
                            "tglpesan": DateFormat("yyyy-MM-dd HH:mm:ss")
                                .format(DateTime.now()),
                            "regular": regulerx
                                ? int.parse(regularjumlahcontroller.text)
                                : 0,
                            "helm": helmx
                                ? int.parse(helmjumlahcontroller.text)
                                : 0,
                            "selimut": selimutx
                                ? int.parse(selimutjumlahcontroller.text)
                                : 0,
                            "karpet": karpetx
                                ? int.parse(karpetjumlahcontroller.text)
                                : 0,
                            "bayar": totalbayar,
                            "status": 1
                          };
                          int idtrx = 0;
                          await dbFuture.then((database) async {
                            idtrx = await databaseHelper
                                .insertTransaksi(transaksibaru);
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Order()));
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Detail Order"),
                        content: Container(
                          height: 200,
                          child: Column(
                            children: <Widget>[
                              Text(
                                namacustomer != null
                                    ? listcutomer[int.parse(namacustomer)]
                                    : "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              regulerx
                                  ? Text("Reguler Kiloan Rp.7000 * " +
                                      regularjumlahcontroller.text.toString() +
                                      "kg = Rp.$totalregular")
                                  : Container(),
                              helmx
                                  ? Text("Helm Rp.15000 * " +
                                      helmjumlahcontroller.text.toString() +
                                      " buah = Rp.$totalhelm")
                                  : Container(),
                              selimutx
                                  ? Text("Selimut Rp.5000 * " +
                                      selimutjumlahcontroller.text.toString() +
                                      " buah = Rp.$totalselimut")
                                  : Container(),
                              karpetx
                                  ? Text("Karpet Rp.9000 * " +
                                      karpetjumlahcontroller.text.toString() +
                                      " buah = Rp.$totalkarpet")
                                  : Container(),
                              Text(
                                "Total Rp." + totalbayar.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          continueButton,
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: Text("Lanjut")),
                Container(
                  margin: EdgeInsets.all(25),
                )
              ]),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:laundryapl/utils/database_helper.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String namacustomer;
  Map<int, String> listcutomer = {};

  _CustomerState() {
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
          print(newcustomerlist);
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
    String nama = "";
    String telepon = "";
    String email = "";
    String alamat = "";
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text("Daftar Customer"),
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
                    ),
                    SizedBox(
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 3,
                        color: Colors.black,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Buat Customer Baru",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                decoration:
                                    InputDecoration.collapsed(hintText: "Nama"),
                                onChanged: (text) {
                                  nama = text;
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: "Telepon"),
                                onChanged: (text) {
                                  telepon = text;
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: "Email"),
                                onChanged: (text) {
                                  email = text;
                                  print("email = $email");
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: "Alamat"),
                                onChanged: (text) {
                                  alamat = text;
                                },
                              ),
                            ),
                          ),
                          Align(
                            child: RaisedButton(
                                child: Text("Simpan Customer"),
                                onPressed: () async {
                                  if (nama.isNotEmpty &&
                                      telepon.isNotEmpty &&
                                      email.isNotEmpty &&
                                      alamat.isNotEmpty) {
                                    final Future<Database> dbFuture =
                                        databaseHelper.initializeDatabase();

                                    await dbFuture.then((database) async {
                                      Map<String, dynamic> customer = {
                                        'nama': nama,
                                        'hp': telepon,
                                        'email': email,
                                        'alamat': alamat
                                      };
                                      await databaseHelper
                                          .insertCustomer(customer);
                                    });

                                    showDialog(
                                        context: context,
                                        builder: (_) => new AlertDialog(
                                              title: Text("pesan"),
                                              content: Text(
                                                  "Sukses Menyimpan Customer"),
                                            ));
                                    setState(() {
                                      listrefresh();
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => new AlertDialog(
                                              title: Text("pesan"),
                                              content: Text(
                                                  "Semua Field Harus Diisi"),
                                            ));
                                  }
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}

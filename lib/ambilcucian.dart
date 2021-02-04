import 'package:flutter/material.dart';

class AmbilCucian extends StatefulWidget {
  @override
  _AmbilCucianState createState() => _AmbilCucianState();
}

class _AmbilCucianState extends State<AmbilCucian> {
  String nomororder;
  String nomorhp;
  String nama;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
              child: ListView(children: <Widget>[
                Text(
                  "Silahkan Masukan nomor order atau nomor telepon atau nama customer yang ingin dicari",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Nomor Order"),
                    textAlign: TextAlign.center,
                    onChanged: (text) {
                      nomororder = text;
                    },
                  ),
                ),
                Text(
                  "atau",
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Nomor HP"),
                    textAlign: TextAlign.center,
                    onChanged: (text) {
                      nomorhp = text;
                    },
                  ),
                ),
                Text(
                  "atau",
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Nama Customer"),
                    textAlign: TextAlign.center,
                    onChanged: (text) {
                      nama = text;
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text("Cari"),
                )
              ]),
            )));
  }
}

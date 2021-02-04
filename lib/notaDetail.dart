import 'package:flutter/material.dart';
import 'package:laundryapl/utils/database_helper.dart';

class DetailNota extends StatefulWidget {
  final String id;
  final String tanggalorder;
  final String nama;
  final int regular;
  final int helm;
  final int selimut;
  final int karpet;
  int total;
  DetailNota(this.id, this.tanggalorder, this.nama, this.regular, this.helm,
      this.selimut, this.karpet, this.total);

  @override
  _DetailNotaState createState() => _DetailNotaState();
}

class _DetailNotaState extends State<DetailNota> {
  DatabaseHelper helper = DatabaseHelper();

  _DetailNotaState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'NOTA LAUNDRY',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            )),
            DividerLine(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Id'),
                      Text("#" + (widget.id.isNotEmpty ? widget.id : "")),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tanggal Order'),
                      Text(widget.tanggalorder.isNotEmpty
                          ? widget.tanggalorder
                          : ""),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Customer'),
                      Text(widget.nama != null ? widget.nama : ""),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kasir'),
                      Text('Demo Kasir'),
                    ],
                  ),
                ],
              ),
            ),
            DividerLine(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cucian Regular'),
                      Text(widget.regular.toString() + "kg"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cucian Helm'),
                      Text(widget.helm.toString() + " buah"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cucian Selimut'),
                      Text(widget.selimut.toString() + " buah"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cucian Karpet'),
                      Text(widget.karpet.toString() + " buah"),
                    ],
                  ),
                ],
              ),
            ),
            DividerLine(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      Text(
                        "Rp. " + widget.total.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DividerLine(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text('Status'),
                  Text(
                    "SUKSES",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            DividerLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Powered By Laundy App By Kelompok 11',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DividerLine(),

            SizedBox(
              height: 150,
            ),
            //Button
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Colors.white,
              child: Text(
                'Cetak Nota',
                textScaleFactor: 1.5,
              ),
              onPressed: () {
                setState(() {
                  _showAlertDialog('Status', 'Nota Berhasil Dicetak');
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //Alert Dialog
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

//divider
class DividerLine extends StatelessWidget {
  const DividerLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('============================================'));
  }
}

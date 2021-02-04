import 'package:flutter/material.dart';
import 'package:laundryapl/notaDetail.dart';
import 'dart:async';
import 'package:laundryapl/model/noteOrder.dart';
import 'package:laundryapl/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Nota extends StatefulWidget {
  @override
  _NotaState createState() => _NotaState();
}

class _NotaState extends State<Nota> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      body: getOrderListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetailNota(Note(1, 1, '', '', 0, ''));
        },
        tooltip: 'Add Order',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getOrderListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getStatusColor(this.noteList[position].status),
              child: getStatusIcon(this.noteList[position].status),
            ),
            title: Text(this.noteList[position].nama),
            subtitle: Text(this.noteList[position].harga.round().toString()),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetailNota(this.noteList[position]);
            },
          ),
        );
      },
    );
  }

  // status color
  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  // status icon
  Icon getStatusIcon(int status) {
    switch (status) {
      case 1:
        return Icon(Icons.error);
        break;
      case 2:
        return Icon(Icons.check);
        break;

      default:
        return Icon(Icons.check);
    }
  }

//navigate to detail nota
  void navigateToDetailNota(Note note) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Container();
    }));

    if (result == true) {
      updateListView();
    }
  }

//update list
  void updateListView() {
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {

    // 	Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
    // 	noteListFuture.then((noteList) {
    // 		setState(() {
    // 		  this.noteList = noteList;
    // 		  this.count = noteList.length;
    // 		});
    // 	});
    // });
  }
}

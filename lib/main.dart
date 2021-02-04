import 'package:flutter/material.dart';
import 'package:laundryapl/ambilcucian.dart';
import 'package:laundryapl/customer.dart';
import 'package:laundryapl/laporan.dart';
import 'package:laundryapl/neworder.dart';
import 'package:laundryapl/order.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<Widget> list = [
    Customer(),
    Order(),
    NewOrder(),
    AmbilCucian(),
    Laporan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laundy App"),
        centerTitle: true,
      ),
      drawer: MyDrawer(
        onTap: (ctx, i) {
          setState(() {
            index = i;
            Navigator.pop(ctx);
          });
        },
      ),
      body: list[index],
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;

  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/laundry.png"),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Laundry App",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "laundryappbykelompok11@gmail.com",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Customer"),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("List Order"),
              onTap: () => onTap(context, 1),
            ),
            ListTile(
              leading: Icon(Icons.library_add),
              title: Text("Order Baru"),
              onTap: () => onTap(context, 2),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Ambil Cucian"),
              onTap: () => onTap(context, 3),
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text("Laporan Harian"),
              onTap: () => onTap(context, 4),
            ),
          ],
        ),
      ),
    );
  }
}

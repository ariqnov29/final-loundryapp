import 'package:flutter/material.dart';

class StepStatus extends StatelessWidget {
  final int indexstatus;
  StepStatus(this.indexstatus);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleStep("Pending", 1, indexstatus > 0 ? true : false),
            LineStep(),
            CircleStep("Pickup", 2, indexstatus > 1 ? true : false),
            LineStep(),
            CircleStep("Proses Cuci", 3, indexstatus > 2 ? true : false),
            LineStep(),
            CircleStep("Dikirim", 4, indexstatus > 3 ? true : false),
            LineStep(),
            CircleStep("Selesai", 5, indexstatus > 4 ? true : false),
          ],
        ),
      ),
    );
  }
}

class LineStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2.0,
      child: Center(
        child: Container(
          width: 20,
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 1.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class CircleStep extends StatelessWidget {
  final String name;
  final int number;
  final bool active;

  CircleStep(this.name, this.number, this.active);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Center(
              child: Text(
            this.number.toString(),
            style: TextStyle(
                fontSize: 15, color: this.active ? Colors.white : Colors.black),
          )),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: this.active ? Colors.blue : Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(18))),
        ),
        Text(
          this.name,
          style: TextStyle(
              fontSize: 11, color: this.active ? Colors.blue : Colors.black),
        )
      ],
    );
  }
}

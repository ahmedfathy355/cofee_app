import 'package:flutter/material.dart';
import 'dart:math';

class ReservedTables extends StatefulWidget {
  ReservedTables({Key key , this.title}) : super ( key : key);
  final String title;
  @override
  _ReservedTablesState createState() => _ReservedTablesState();
}

class _ReservedTablesState extends State<ReservedTables> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              color: Colors.redAccent),
                        ),
                        Text('Out of Service')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              color: Colors.grey),
                        ),
                        Text('Booked')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              color: Colors.greenAccent),
                        ),
                        Text('Avaliable')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 20),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  // if (index % 11 == 5) {
                  //   return Container(
                  //     width: 100,
                  //     height: 100,
                  //   );
                  // } else {
                    // int mode = Random().nextInt(4);
                    // Color color = Colors.greenAccent;
                    // if (mode == 0)
                    //   color = Colors.greenAccent;
                    // else if (mode == 1)
                    //   color = Colors.redAccent;
                    // else if (mode == 2) color = Colors.grey;

                    return Container(
                      width: 100,
                      height: 100,
                      child: Center(child: Text('table $index',style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.lightGreenAccent),),),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(30))),
                        color: Colors.grey,
                      ),
                    );
                  //}
                },
              ),
            ),
          ],
        ),
      );
  }
}
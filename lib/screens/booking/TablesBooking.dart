import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gamestop_app/menu/mainMenu.dart';
import 'package:gamestop_app/modle/table_row.dart';


class TablesBooking extends StatefulWidget {

  @override
  _TablesBookingState createState() => _TablesBookingState();
}

class _TablesBookingState extends State<TablesBooking> {
 var lst = ["A","B","C","D"];
 String vars_t = "";

 List<Table_Row> selectedTables = [] ;
 var _bookstatuscolor = [Colors.green, Colors. grey, Colors. red] ;

  @override
  void initState() {
      super.initState();
    }

  @override
  void dispose(){
   super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: Card(
                      elevation: 2,
                      color: Colors.lightGreenAccent,
                      child: Center(heightFactor: 1,child: Text('Bar Here ....',style: TextStyle(color: Colors.pink),),),
                    ),
                  ),


                  Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                    itemCount: lst.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 40),
                    itemBuilder: (BuildContext _context , int index){
                      return  GestureDetector(
                        child: Card(
                          elevation: 5,
                          color: _bookstatuscolor[0],
                          child:  Container(alignment: Alignment.centerLeft,
                                margin:  EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
                                child: Text(lst[index])
                          ),
                        ),
                        onTap: (){
                          setState(() {
                              vars_t = lst[index];
                              selectedTables.add(lst[index], 0);
                            }
                          );
                          _handleSelectSeat(lst[index]);
                          _showModalSheet();
                          //Navigator.push(context, MaterialPageRoute( builder: (context) =>  ));
                        },
                      );
                    },
                  ),
                  ),

                  new Text(vars_t),


                  Row(
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


                ],
              ),

          ),

      );




  }



 void _showModalSheet() {
   showModalBottomSheet(context: context, builder: (builder) {
     return Container(
       child: openMenu(),
       //padding: EdgeInsets.only(top: 40),
     );
   },
      isScrollControlled: true);
 }




 void _handleSelectSeat(String table) {
   setState(() {
     if (!selectedTables.containsKey(table)) {
       selectedTables[table] = true;
     } else {
       selectedTables[table] = !selectedTables[table];
     }
   });
 }

}

















import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gamestop_app/menu/mainMenu.dart';


class TablesBooking extends StatefulWidget {

  @override
  _TablesBookingState createState() => _TablesBookingState();
}

class _TablesBookingState extends State<TablesBooking> {
 var lst = ["A","B","C","D"];
 String vars_t = "";

 HashMap<String, bool> selectedTables = HashMap();

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
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (BuildContext _context , int index){
                      return  GestureDetector(
                        child: Card(
                          elevation: 5,
                          color: Colors.green,
                          child:  Container(alignment: Alignment.centerLeft,
                                margin:  EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
                                child: Text(lst[index])
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            vars_t = lst[index];
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

                ],
              ),

          ),

      );




  }



 void _showModalSheet() {
   showModalBottomSheet(context: context, builder: (builder) {
     return Container(
       child: openMenu(),
       padding: EdgeInsets.all(40.0),
     );
   },
      isScrollControlled: true);
 }




 void _handleSelectSeat(String table) {
   setState(() {
//     if (!selectedSeats.containsKey(table)) {
//       selectedSeats[table] = true;
//     } else {
//       selectedSeats[table] = !selectedSeats[table];
//     }
   });
 }

}

















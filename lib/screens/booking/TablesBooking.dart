import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gamestop_app/menu/mainMenu.dart';
import 'package:gamestop_app/modle/table_row.dart';
import 'package:gamestop_app/screens/booking/Order.dart';
import 'package:gamestop_app/utility/COLOR_CONST.dart';


class TablesBooking extends StatefulWidget {


  @override
  _TablesBookingState createState() => _TablesBookingState();
}

class _TablesBookingState extends State<TablesBooking> {


  String table_id = "";
  List<Table_Slot> _Table_Slots = [] ;
  bool isbooked ;

//  TablesBooking(
//      {@required this.table_id, @required this.isbooked});

 HashMap<String, bool> selectedTables = HashMap();
 int maxColumn;
 List<Table_Slot> Table_Slots_DB = [];

 _getTables(){
   Table_Slots_DB = List<Table_Slot>();
   Table_Slots_DB.add(Table_Slot(tableid: "Table 1" , booked: true));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 2" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 3" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 4" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 5" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 6" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 7" , booked: true));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 8" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 9" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 10" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 11" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 12" , booked: false));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 13" , booked: true));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 14" , booked: true));
   Table_Slots_DB.add(Table_Slot(tableid: "Table 15" , booked: true));

   //widget._Table_Slots = Table_Slots_DB;
   return Table_Slots_DB;
 }

  @override
  void initState() {
      maxColumn = 8;

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

                  // Bar
                  Padding(
                    padding: const EdgeInsets.only(right: 1,left: 1,top: 25,bottom: 5),
                    child: Container(
                      height: 60,
                      child: Card(
                        elevation: 2,
                        color: COLOR_CONST.Bar,
                        child: Center(child: Image.asset('assets/images/bar3.png', color: Colors.white, ),),
                      ),
                    ),
                  ),

                  // الوان حالة الترابيزات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                                color: COLOR_CONST.GRAY1_50),
                            child: Icon(Icons.check_circle_outline,color: Colors.blue[900].withOpacity(0.8),),
                          ),
                          Text('متاحة')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                                color: COLOR_CONST.Pink),
                            child: Icon(Icons.people_outline,color: Colors.white.withOpacity(0.8),),
                          ),
                          Text('مشغوله')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                                color: Colors.greenAccent),
                            child: Icon(Icons.highlight_off,color: Colors.white,),
                          ),
                          Text('معطلة')
                        ],
                      ),
                    ],
                  ),

                  // Tables
                  _buildSlotGrid(),

                ],
              ),

          ),

      );


  }



  // Create Tables
 _buildSlotGrid() {
   return Padding(
     padding: const EdgeInsets.only(left: 10,right: 10),
     child: ConstrainedBox(
       constraints: BoxConstraints(
       ),
       child: GridView.count(
         shrinkWrap: true,
         physics: new AlwaysScrollableScrollPhysics(),
         crossAxisCount: 3,
         scrollDirection: Axis.vertical,
         childAspectRatio: 3/2,
         crossAxisSpacing: 40,
         mainAxisSpacing: 30/2,
         children: _generatedGrid(),

       ),
     ),
   );
 }
 List<Widget> _generatedGrid() {
   _getTables();
   List<Widget> widgets = [];

   Table_Slots_DB.forEach((Table_Slot) {

     //ITEM TABLE
     //for (int i = 0; i < Table_Slot.tableid.length ; i++) {
       var tableId = "${Table_Slot.tableid}";
       var _isbooked = Table_Slot.booked;

       var isSelected =
           selectedTables.containsKey(tableId) && selectedTables[_isbooked];

       var itemBgColor = COLOR_CONST.GRAY1_50;
       var itemBorderColor = Colors.black54;
       var itemfontColor = Colors.blue[900];

       if (_isbooked) {
         itemBgColor = COLOR_CONST.Pink;
         itemfontColor = Colors.white;
       }
       var itemAvailable = GestureDetector(
         onTap: () {
           if (!_isbooked) {

             _showModalSheet(Table_Slot.tableid);
             //Navigator.push(context, MaterialPageRoute( builder: (context) =>  ));
           }
           else{
             Navigator.push(context, MaterialPageRoute( builder: (context) => OrderScreen() ));
             //Navigator.push(context, MaterialPageRoute( builder: (context) => OrderDetailsScreen() ));
           }
         },
         child: Container(
           decoration: BoxDecoration(
             color: itemBgColor,
             borderRadius: BorderRadius.circular(4),
             border: Border.all(
               color: itemBorderColor,
               width: 1,
             ),
           ),
            //child: Center(child: Text(Table_Slot.tableid.split(" ")[1],style: TextStyle(fontFamily: 'Oswald',color: itemfontColor,fontWeight: FontWeight.bold , fontSize: 25),) )
           child: Center(
             child: Stack(
               alignment: Alignment(0, 0),
               children: <Widget>[
                 Text(Table_Slot.tableid.split(" ")[1],style: TextStyle(fontFamily: 'Oswald',color: itemfontColor,fontWeight: FontWeight.bold , fontSize: 25),),
                 Image.asset('assets/images/chair.png',height: 265,width: 265,color: itemfontColor.withOpacity(0.4) ,)
               ],
             ),
           ),
       ),

       );

       var itemEmpty = Container();

       widgets.add( itemAvailable);
     //}
   });

   return widgets;
 }
 void _handleSelectTable(Table_Slot table_slot ) {

 }









 void _showModalSheet(String tableID) {
   showModalBottomSheet(context: context, builder: (builder) {
     return Container(
       child: openMenu(tableID),
       //padding: EdgeInsets.only(top: 40),
     );
   },
      isScrollControlled: true);
 }






}

















import 'package:flutter/cupertino.dart';
import 'package:gamestop_app/menu/mainMenu.dart';

class Table_Slot {

  String tableid;
  bool booked;
  List<Items> TableItems;

  Table_Slot({
    @required this.tableid,
    @required this.booked,
  });
}

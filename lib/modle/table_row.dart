import 'package:flutter/cupertino.dart';

class Table_Row {
  //A, B, C, ...
  String rowId;
  int count;
  List<int> offs = [];
  List<int> booked = [];

  Table_Row({
    @required this.rowId,
    @required this.count,
    @required this.offs,
    @required this.booked,
  });
}

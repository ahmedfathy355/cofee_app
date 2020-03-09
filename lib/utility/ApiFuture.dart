import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gamestop_app/modle/Items.dart';

 class RestAPI{


  Future _insertItems(String table_id , String ItemID , double Qty) async {
    var sql = "insert Into bill_items_test (tableID,ItemID, Qty) Values ('$table_id' , '$ItemID' , $Qty) ";
    await http.get('http://ubuntu-eg.com/snap_api/insert.php?sql=$sql');
    print('inserted');
    //selecteditems.clear();
  }

  static Future _getItems2() async {}



}
import 'package:flutter/material.dart';


class Items{
  String ItemID;
  String ItemName;
  double LowPriceSale;
  String Barcode;
  int BranchID;

  Items(this.ItemID , this.ItemName , this.LowPriceSale,this.Barcode,this.BranchID );
  //Items( this.ItemName );

  Items.fromJson(Map<Object , dynamic> json){
    ItemID = json['ItemID'].toString();
    ItemName = json['ItemName'].toString();
    LowPriceSale = json['LowPriceSale'];
    Barcode = json["Barcode"].toString();
    BranchID = json["BranchID"];
  }

}
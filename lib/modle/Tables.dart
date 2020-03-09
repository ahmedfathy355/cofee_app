import 'package:gamestop_app/modle/table_row.dart';

class Tables{
  int TableID;
  String TableName;
  bool IsBooked;


  Tables(this.TableID , this.TableName , this.IsBooked  );
  //Items( this.ItemName );

  Tables.fromJson(Map<Object , dynamic> json){
    TableID = json['TableID'];
    TableName = json['TableName'].toString();
    IsBooked = json['IsBooked'];
  }

}
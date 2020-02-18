import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamestop_app/menu/fab_bottom_app_bar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class openMenu extends StatefulWidget {
  @override
  _openMenuState createState() => _openMenuState();
}

class _openMenuState extends State<openMenu> {

  String _lastSelected = 'TAB: 0';
  List<Items> items = [] ;
  List<Items> selecteditems = [];
  List<int> _itemCount = [];


  Future<List<Items>> _getItems() async {
    var sql = "Select * From items_test";
    var get_response = await http.get('http://ubuntu-eg.com/snap_api/select.php?sql=$sql');
    items = List<Items>();
    if(get_response.statusCode == 200){
      var jsondata = json.decode(get_response.body);
      for(var itm in jsondata){
        items.add(Items.fromJson(itm));
      }
    }
    print(items.length.toString());
    return items;

  }

  Future<List<Items>> _insertItems() async {
    var sql = "Select * From items_test";
    var get_response = await http.get('http://ubuntu-eg.com/snap_api/select.php?sql=$sql');
    items = List<Items>();
    if(get_response.statusCode == 200){
      var jsondata = json.decode(get_response.body);
      for(var itm in jsondata){
        items.add(Items.fromJson(itm));
      }
    }
    print(items.length.toString());
    return items;

  }

  var listPoduct  = StreamController<List<Items>>();

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }


  Future _future;
  @override
  void initState() {
//    _getItems().then((value) {
//      setState(() {
//        items.addAll(value);
//      });
//    });

    _future = _getItems();
    listPoduct.sink.add(items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        child: Column(
          children: <Widget>[
            //Search
            Padding(
              padding: EdgeInsets.only(top: 40,left: 30,right: 30),
              child: TextField(
                onChanged: (value){
                   filteritems(value);
                },
                //controller: editingControll,
                decoration: InputDecoration(
                  labelText: 'بحث',
                  hintText: '',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),

            //List Items
            Expanded(
              child: FutureBuilder(future: _future,
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  print(snapshot.data);
                  if(snapshot.data == null)
                  {
                    return Container(
                      child: Center(
                        child: Text('Loading ....'),
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context , index){
                        return ListTile(

                          title: Text(snapshot.data[index].ItemName , style: TextStyle(fontSize: 22), ),

                          leading: CircleAvatar(backgroundColor: Colors.purple,foregroundColor: Colors.black,
                            backgroundImage: AssetImage('assets/images/'+snapshot.data[index].img+''),
                            child: snapshot.data[index].img!= null ? Text('c',style: TextStyle(color: Colors.white)): Text(''),
                          ),
                          subtitle: Text(snapshot.data[index].U_Price + '   LE' ),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              items[index].qty!=0? IconButton(alignment: Alignment.bottomCenter, icon: new Icon(Icons.remove) , color: Colors.purple,iconSize: 30,onPressed: ()=>setState(() => _update(index, -1)),): Container(),

                              SizedBox(width: 10,),

                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(color: Colors.purple , width: 1 ),
                                ),
                                     child: Center(
                                       child: Text(
                                         items[index].qty.toString()
                                         ,style: TextStyle(color: Colors.purple,fontSize: 22,fontWeight: FontWeight.bold),),
                                     ),
                              ),

                              SizedBox(width: 10,),

                              IconButton(icon: new Icon(Icons.add),color: Colors.purple,iconSize: 30,onPressed: ()=>setState((){
                                //snapshot.data[index].qty++;
                                _update(index, 1);
                              }
                              )),


                            ],
                          ),
                        );
                      },

                    );
                  }
                 },
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _insertItems();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'حفظ',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: 'مشروبات'),
          FABBottomAppBarItem(iconData: Icons.layers, text: 'عصائر'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'العاب'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'سينما'),

        ],
      ),




    );

  }


  _update(int index,int val ) {
    for (int i = 0; i < items.length; i++ ) {
      if (i == index) {
        items[i] =Items(items[i].ItemID,items[i].ItemName,items[i].U_Price,items[i].img,items[i].qty + val);
      }
    }
    selecteditems.add(Items(items[index].ItemID,items[index].ItemName,items[index].U_Price,items[index].img,items[index].qty + val)   );
    listPoduct.add(items);
  }

  void filteritems(String query) {
    List<Items> dummySearchList = List<Items>();
    dummySearchList.addAll(items);
    if(query.isNotEmpty) {
      List<Items> dummyListData = List<Items>();
      dummySearchList.forEach((item) {
        if(item.ItemName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(items);
      });
    }

  }



}


class Items{
  String ItemID;
  String ItemName;
  String U_Price;
  String img;
  int qty;

  Items(this.ItemID , this.ItemName , this.U_Price,this.img,this.qty );
  //Items( this.ItemName );

  Items.fromJson(Map<Object , dynamic> json){
    ItemID = json['ItemID'].toString();
    ItemName = json['ItemName'].toString();
    U_Price = json['U_Price'].toString();
    img = json["img"].toString();
    qty = 0;
  }

}
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamestop_app/menu/fab_bottom_app_bar.dart';
import 'package:gamestop_app/modle/Items.dart';
import 'package:gamestop_app/utility/utils.dart';
import 'package:gamestop_app/utility/COLOR_CONST.dart';
import 'package:gamestop_app/utility/FONT_CONST.dart';
import 'package:gamestop_app/widgets/loader.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class openMenu extends StatefulWidget {

  var tableID;
  openMenu(@required this.tableID);

  @override
  _openMenuState createState() => _openMenuState();
}

class _openMenuState extends State<openMenu> {

  String _lastSelected = 'TAB: 0';
  List<Items> items = [] ;
  List<Items> selecteditems = [];
  List<int> _itemCount = [];

  var itm_cat = 1;
  Future<List<Items>> _getItems_x() async {
    var sql = "Select * From items_test Where Item_Cat = '$itm_cat' ";
    var get_response = await http.get('http://ubuntu-eg.com/snap_api/select.php?sql=$sql');
    items = List<Items>();
    print(get_response.statusCode);
    if(get_response.statusCode == 200){
      var jsondata = json.decode(get_response.body);
      for(var itm in jsondata){
        items.add(Items.fromJson(itm));
      }
    }
    print(items.length.toString());
    return items;

  }



  Future<List<Items>> _getItems() async {

    var get_response = await http.get(Utils.RestURL + 'test');

    items = List<Items>();
    print(get_response.statusCode.toString() + 'XXXXXXXXXXXXXXXX');
    if(get_response.statusCode == 200){
      var jsondata = json.decode(get_response.body);
      for(var itm in jsondata){
        items.add(Items.fromJson(itm));
      }
    }
    print(items.length.toString());
    return items;

  }


  Future _insertItems(String table_id , String ItemID , double Qty) async {
    var sql = "insert Into bill_items_test (tableID,ItemID, Qty) Values ('$table_id' , '$ItemID' , $Qty) ";
    await http.get(Utils.RestURL );
    print('inserted');
    selecteditems.clear();
  }



  var listPoduct  = StreamController<List<Items>>();

  void _selectedTab(int index) {
    setState(() {
      itm_cat= index+1;
      _future = _getItems();
      //_getItems();
    });
  }

  TextEditingController _controller = new TextEditingController();
  Future _future;

  @override
  void initState() {
    _future = _getItems();
    listPoduct.sink.add(items);
    super.initState();
  }

  int value = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        child: Column(
          children: <Widget>[
            //Search
            Padding(
              padding: EdgeInsets.only(top: 40,left: 30,right: 30),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                   TextField(
                      onChanged: (value){
                        filteritems(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'بحث',
                        hintText: '',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      controller: _controller,
                    ),

                  FlatButton(
                      onPressed: () {
                        _controller.clear();
                        _getItems();
                      },
                      child: new Icon(Icons.highlight_off,color: Colors.grey[500],),)
                ],
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
                        //child: Text('Loading ....'),
                        child: LoaderTwo(),
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context , index){
                        return ListTile(

                          title: Text(snapshot.data[index].ItemName , style: TextStyle(fontSize: 16), ),

                          leading: CircleAvatar(backgroundColor: Colors.purple,foregroundColor: Colors.black,
                            backgroundImage: AssetImage('assets/images/'+snapshot.data[index].Barcode+''),
                            child: snapshot.data[index].Barcode!= null ? Text('c',style: TextStyle(color: Colors.white)): Text(''),
                          ),
                          subtitle: Text(snapshot.data[index].LowPriceSale.toString() + '   LE' ),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

//                              items[index].qty!=0? IconButton(alignment: Alignment.bottomCenter, icon: new Icon(Icons.remove) , color: Colors.purple,iconSize: 30,onPressed: ()=>setState(() => _update(index, -1)),): Container(),
//
//                              SizedBox(width: 10,),
//
//                              Container(
//                                width: 30,
//                                height: 30,
//                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                                                          border: Border.all(color: Colors.purple , width: 1 ),
//                                ),
//                                     child: Center(
//                                       child: Text(
//                                         items[index].qty.toString()
//                                         ,style: TextStyle(color: Colors.purple,fontSize: 22,fontWeight: FontWeight.bold),),
//                                     ),
//                              ),
//
//                              SizedBox(width: 10,),
//
//                              IconButton(icon: new Icon(Icons.add),color: Colors.purple,iconSize: 30,onPressed: ()=>setState((){
//                                //snapshot.data[index].qty++;
//                                _update(index, 1);
//                              }
//                              )),







                              /// Decrease of value item
                              items[index].qty!=0? InkWell(
                                onTap: () {
                                  setState(() {
                                    _update(index, -1);
                                  });
                                },
                                child: Container(
                                  height: 30.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black12
                                                  .withOpacity(0.5)))),
                                  child: Center(child: Text("-" ,style: FONT_CONST.OSWALD_REGULAR_RED2_22,)),
                                ),
                              ): Container(),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(items[index].qty.toString(),style: FONT_CONST.OSWALD_REGULAR_RED2_22,),
                              ),

                              /// Increasing value of item
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _update(index, 1);

                                  });
                                },
                                child: Container(
                                  height: 30.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.black12
                                                  .withOpacity(0.4)))),
                                  child: Center(child: Text("+",style: TextStyle(fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w400,
                                      color: COLOR_CONST.GREEN2,fontSize: 22 ),)),
                                ),
                              ),










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
          for(int i = 0 ; i < selecteditems.length ;i++ ){
            //_insertItems(widget.tableID.toString() , selecteditems[i].ItemID , double.tryParse( selecteditems[i].qty.toString()));
          }
          Navigator.of(context).pop();
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
        items[i] =Items(items[i].ItemID,items[i].ItemName,items[i].LowPriceSale,items[i].Barcode,items[i].BranchID,items[i].qty + val);
      }
    }
    selecteditems.add(Items(items[index].ItemID,items[index].ItemName,items[index].LowPriceSale,items[index].Barcode,items[index].BranchID ,items[index].qty+ val)   );
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



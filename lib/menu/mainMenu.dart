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


  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  @override
  void initState() {
    _getItems().then((value) {
      setState(() {
        items.addAll(value);
      });
    });
    super.initState();
  }
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(future: _getItems(),
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

                    title: Text(snapshot.data[index].ItemName),

                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/kitchen.png'),),
                    subtitle: Text(snapshot.data[index].U_Price + '   LE'),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),): Container(),
                        Container(
                               child: Text(_itemCount.toString()),
                        ),

                        IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
                      ],
                    ),
                  );
                },

              );
            }
           },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
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






}


class Items{
  String ItemID;
  String ItemName;
  String U_Price;

  Items(this.ItemID , this.ItemName , this.U_Price);
  //Items( this.ItemName );

  Items.fromJson(Map<Object , dynamic> json){
    ItemID = json['ItemID'].toString();
    ItemName = json['ItemName'].toString();
    U_Price = json['U_Price'].toString();
  }

}
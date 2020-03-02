import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamestop_app/screens/booking/chef.dart';

import 'booking/TablesBooking.dart';

class Home_App_Type extends StatefulWidget {
  @override
  _Home_App_TypeState createState() => _Home_App_TypeState();
}

class _Home_App_TypeState extends State<Home_App_Type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 80),

        children: <Widget>[

          SizedBox(height: 150,),


          GestureDetector(
            child:_buildWikiCategory(FontAwesomeIcons.screwdriver,
                "Chef", Colors.deepOrange.withOpacity(0.7)),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChefScreen() ));
            },
          ),

          SizedBox(height: 50,),

          GestureDetector(
            child:_buildWikiCategory(
                       FontAwesomeIcons.table, "Captin", Colors.blue),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TablesBooking() ));
            },
          ),

                 //


//          SizedBox(height: 16.0),
//
//          Row(
//            children: <Widget>[
//               GestureDetector(
//
//                 child: Expanded(
//                   flex: 1,
//                   child: _buildWikiCategory(
//                       FontAwesomeIcons.file, "Captin", Colors.greenAccent),
//                 ),
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> TablesBooking() ));
//                 },
//               ),
//            ],
//          ),


        ],
      ),
    );
  }

  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          child: Opacity(
              opacity: 0.3,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),
              )
            ],
          ),
        )
      ],
    );
  }


}

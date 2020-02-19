import 'package:flutter/material.dart';
import 'package:gamestop_app/utility/COLOR_CONST.dart';
import 'package:gamestop_app/utility/FONT_CONST.dart';



class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends StatelessWidget {

  var _totalAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: COLOR_CONST.RED2,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index){
          return ListTile(
            title: Text('عصير  $index',style: FONT_CONST.MEDIUM_BLUE_16,),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "إجمالى الشيك:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: _total(),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  _customizeDialog(context);
                  // print("Clicked");

                  // this.cartService.placeOrder()
                },
                child: Text(
                  "محاسبة واغلاق",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      wordSpacing: 2.0),
                ),
                color: COLOR_CONST.Lime,
              ),
            )
          ],
        ),
      ),
    );
  }







  void showSnackBar(BuildContext context, String text) {
    var snackBar = SnackBar(
      backgroundColor: Color.fromRGBO(85, 139, 47, 1),
      duration: const Duration(seconds: 1),
      content: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

// ========== Total of Cart =============
  Widget _total() {
    double totalPrice = 0;
    for (var i = 0; i < 20; i++) {
      totalPrice = 2000;
    }
    this._totalAmount = totalPrice;
    return Text(
      "\جنية $totalPrice",
      style: TextStyle(color: Colors.teal.shade600),
    );
  }

  // ========= Individual Cart Item =============
  Widget _buildCartItem() {
    return Card(
      child: ListTile(
        leading: Image.asset(
          'assets/images/table.png',
          width: 80.0,
          height: 80.0,
          fit: BoxFit.fitHeight,
        ),
        title: Text('nameXXXXXXXXXXXX'),
        subtitle: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: Text("\$ ${20.0}"),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Container(
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  iconSize: 50.0,
                  onPressed: () {
                    print("Clicked");
                    //cartService.increaseQuantity(document.documentID);
                  },
                ),
                Text(50.toString(),
                    style: TextStyle(fontSize: 40.0, color: Colors.red)),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 50.0,
                  onPressed: () {
                    //cartService.decreaseQuantity(document.documentID);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== Customization dialog  ==========
  Future<bool> _customizeDialog(context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Customization'),
            content: TextFormField(
              controller: customController,
              maxLines: 5,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
//                  cartService
//                      .placeOrder(
//                      customController.text.toString(), this._totalAmount)
//                      .then((r) {
//                    print("Order placed");
//                  });
                  // this.showSnackBar(context, "Order Placed..");
                },
              )
            ],

            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0)),
            // child: Container(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Container(
            //         child:
            //       ),
            //       Align(
            //         alignment: Alignment.bottomCenter,
            //         child: FlatButton(
            //             color: Color.fromRGBO(161, 221, 112, 1),
            //             child: Text(
            //               "Apply",
            //               style: TextStyle(
            //                   color: Colors.white.withOpacity(0.7),
            //                   fontFamily: "Montserrat",
            //                   fontSize: 20.0,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //               cartService
            //                   .placeOrder(customController.text.toString())
            //                   .then((r) {
            //                 print("Order placed");
            //                 // this.showSnackBar(context, "Order Placed..");
            //               });
            //             }),
            //       )
            //     ],
            //   ),
            //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            // ),
          );
        });
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog();
        });
  }

}

import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [

        AppBar(
          title: Text("Hello Friend !"),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Shop"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text("Orders"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(OrderScreen.routename);
          },
        ),
      ],),
      
    );
  }
}
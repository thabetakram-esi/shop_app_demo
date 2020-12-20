import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'providers/products_provider.dart';
import 'screens/detail_screen_product.dart';
import 'screens/product__overview_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> Products(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        
        theme: ThemeData(
          
          primaryColor: HexColor("#ff6501"),
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
          
          

        ),
        //home: ProductOverviewScreen(),
        routes: {

          "/":(context)=>ProductOverviewScreen(),
          DetailScreenProduct.routename:(context)=>DetailScreenProduct(),
          
                },
      ),
    );
  }
}


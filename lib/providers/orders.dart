import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final DateTime datetime;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.datetime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;
  Orders(this.authToken,
  this.userId,
  this._orders);

  Future<void> fetchData() async {
    final url = "https://shopapp-2bf63-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";

    final List<OrderItem> loadedOrders = [];

    final response = await http.get(url);
    final extracteddata = json.decode(response.body) as Map<String, dynamic>;
    if (extracteddata == null) {
     
      print('no data');
      
      _orders=[];
      notifyListeners();
      throw HttpException("No orders to show");
       
      
    }
    extracteddata.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          datetime: DateTime.parse(orderData['datetime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();

    notifyListeners();
    
    
    
  }

  Future<void> addOrders(List<CartItem> productsCart, double amount) async {
    //print(authToken);
    final url = "https://shopapp-2bf63-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': amount,
          'datetime': timestamp.toIso8601String(),
          'products': productsCart
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));

    _orders.insert(
        0,
        OrderItem(
            amount: amount,
            id: json.decode(response.body)['name'],
            products: productsCart,
            datetime: timestamp));

    notifyListeners();
  }
}

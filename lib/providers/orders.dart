import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './cart.dart';

var headers = {
  'X-Parse-Application-Id': 'Noh5VvlAd1aXUXvDCoZJhwpfDfE8P2QEQyCEFZW5',
  'X-Parse-REST-API-Key': 'Zm5fKSTUtIURGDXYpDig6ckMlAteorsT2uMaCOWZ',
};

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    getOrders();
    return [..._orders];
  }

  Future getProducts() async {
    var apiUrl = Uri.https("parseapi.back4app.com", '/classes/orders');
    try {
      final response = await http.get(apiUrl, headers: headers);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getOrders() async {
    try {
      final response = await getProducts();
      final List<OrderItem> loadedOrders = [];
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var results = body["results"];

        if (results == null) {
          return;
        }
        for (var order in results) {
          var item = OrderItem(
            id: order['objectId'],
            amount: order['amount'].toDouble(),
            dateTime: DateTime.parse(order['date']),
            products: (order['products'] as List<dynamic>)
                .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    price: e['price'].toDouble(),
                    quantity: e['quantity']))
                .toList(),
          );
          loadedOrders.add(item);
        }
        _orders = loadedOrders.reversed.toList();
      }
      notifyListeners();
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var apiUrl = Uri.https("parseapi.back4app.com", '/classes/orders');
    final res = await http.post(
      apiUrl,
      headers: {...headers, 'Content-Type': 'application/json'},
      body: json.encode({
        'amount': total,
        'date': DateTime.now().toIso8601String(),
        'products': cartProducts
            .map((e) => {
                  "id": e.id,
                  "title": e.title,
                  "quantity": e.quantity,
                  "price": e.price,
                })
            .toList()
      }),
    );
    print(json.decode(res.body));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(res.body)['objectId'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}

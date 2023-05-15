import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  String id = '';
  bool isFavorite;

  Product({
    this.id = '',
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final apiUrl = Uri.https("parseapi.back4app.com", '/classes/products/$id');
    try {
      final res = await http.put(apiUrl,
          headers: {
            'X-Parse-Application-Id':
                '58x27k9daM3VtLjvOilw9FSK31mNcYBSB8u2X9Sn',
            'X-Parse-REST-API-Key': '5jBk11A86okzXm0oQ7rS0FsFah8hVKS0OTFfURIl',
            'Content-Type': 'application/json',
          },
          body: json.encode(Product(
                  title: title,
                  description: description,
                  price: price,
                  imageUrl: imageUrl,
                  isFavorite: isFavorite)
              .toJson()));
      if (res.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }

    // _items.indexWhere((element) => element.id == id);
    // Product? existingProduct = _items[existingProductIndex];
    // _items.removeAt(existingProductIndex);
    // notifyListeners();
    // http.delete(apiUrl, headers: headers).then((res) {
    //   if (res.statusCode >= 400) {
    //     throw HttpException('could not delete product');
    //   }
    //   existingProduct = null;
    // }).catchError((_) {
    //   items.insert(existingProductIndex, existingProduct!);
    //   notifyListeners();
    // });
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["objectId"],
      title: json["title"],
      description: json["description"],
      price: json["price"].toDouble(),
      imageUrl: json["imageUrl"],
      isFavorite: json["isFavorite"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
        "isFavorite": isFavorite,
      };
}

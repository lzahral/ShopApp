import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'dart:convert';

import 'product.dart';

// var applicationId = '58x27k9daM3VtLjvOilw9FSK31mNcYBSB8u2X9Sn';
// var restAPIKey = '5jBk11A86okzXm0oQ7rS0FsFah8hVKS0OTFfURIl';

var headers = {
  'X-Parse-Application-Id': '58x27k9daM3VtLjvOilw9FSK31mNcYBSB8u2X9Sn',
  'X-Parse-REST-API-Key': '5jBk11A86okzXm0oQ7rS0FsFah8hVKS0OTFfURIl',
};

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products with ChangeNotifier {
  final List<Product> _items = [];
  //var _showFavorites = false;

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get items {
    // if (_showFavorites) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    var apiUrl = Uri.https("parseapi.back4app.com", '/classes/products');

    try {
      final res = await http.post(
        apiUrl,
        headers: {...headers, 'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      //print(json.decode(value.body));
      final newProduct = Product(
          id: json.decode(res.body)['objectId'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);

      //_items.insert(0, newProduct); //at the start of list
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future getProducts() async {
    var apiUrl = Uri.https("parseapi.back4app.com", '/classes/products');
    try {
      final response = await http.get(apiUrl, headers: headers);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getProductList() async {
    try {
      final response = await getProducts();
      // print("Code is ${response.statusCode}");
      // print("Response is ${response.body}");

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var results = body["results"];

        for (var product in results) {
          _items.add(Product.fromJson(product));
          final ids = _items.map((e) => e.id).toSet();
          _items.retainWhere((x) => ids.remove(x.id));
        }
      }
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product editedProduct) async {
    var apiUrl = Uri.https("parseapi.back4app.com", '/classes/products/$id');
    await http.put(apiUrl,
        headers: {
          ...headers,
          'Content-Type': 'application/json',
        },
        body: json.encode(editedProduct.toJson()));
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = editedProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final apiUrl = Uri.https("parseapi.back4app.com", '/classes/products/$id');
    final res = await http.delete(apiUrl, headers: headers);
    if (res.statusCode >= 400) {
      throw HttpException('could not delete product');
    } else {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }

    // final existingProductIndex =
    //     _items.indexWhere((element) => element.id == id);
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
}

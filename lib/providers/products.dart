import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://dkstatics-public.digikala.com/digikala-products/116747200.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/quality,q_90',
    ),
    Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
            'https://dkstatics-public.digikala.com/digikala-products/6b5a23d6bac119b84c9ed018407c1a89d9ebddab_1648311713.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/quality,q_90'),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
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

  void updateProduct(String id, Product editedProduct) {
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = editedProduct;
    notifyListeners();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().microsecond.toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    _items.add(newProduct);
    //_items.insert(0, newProduct); //at the start of list
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  // void showAll() {
  //   _showFavorites = false;
  //   notifyListeners();
  // }
}

import "package:flutter/material.dart";

import "../widgets/product_item.dart";
import '../models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: _items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: ((context, index) => ProductItem(_items[index].id,
                _items[index].title, _items[index].imageUrl))));
  }
}

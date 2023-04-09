import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String url;

  const ProductItem(this.id, this.title, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
            ),
          ),
          child: Image.network(url, fit: BoxFit.scaleDown)),
    );
  }
}

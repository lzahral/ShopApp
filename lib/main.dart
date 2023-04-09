// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme:
          ThemeData(primarySwatch: Colors.red, accentColor: Colors.deepOrange),
      home: ProductsOverviewScreen(),
    );
  }
}

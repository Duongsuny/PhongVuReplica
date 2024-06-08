import 'package:flutter/material.dart';
import 'package:phongvu_copycat/product_showcase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phongvu Product',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 20,53,195),
        useMaterial3: true,
      ),
      home: const ProductShowcase()
    );
  }
}


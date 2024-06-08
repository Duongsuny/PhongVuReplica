import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> imageURLs;
  const ProductCarousel({super.key, required this.imageURLs});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlay: true,
        viewportFraction: 1,
        initialPage: 0,
      ),
      items: imageURLs.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Image.network(
              url
            );
          },
        );
      }).toList(),
    );
  }
}

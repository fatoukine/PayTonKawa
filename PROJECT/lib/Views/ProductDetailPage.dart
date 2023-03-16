import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paytonkawa/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c3e50),
        elevation: 0,
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 26),
            Hero(
              tag: product.name,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2c3e50).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://elcafe.fr/wp-content/uploads/2022/01/delonghi-FEB-2961.SB-carre.jpg',
                      height: 250,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFF2c3e50),
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.black),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text(
              product.details.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.black54),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

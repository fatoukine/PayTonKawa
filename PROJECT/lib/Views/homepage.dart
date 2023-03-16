import 'package:paytonkawa/views/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paytonkawa/views/login.dart';
import 'package:http/http.dart';
import 'package:paytonkawa/components/product_card.dart';
import 'package:paytonkawa/models/product.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import 'ProductDetailPage.dart'; 


class HomePage extends StatelessWidget   {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.coffee),
              SizedBox(width: 10),
              Text('PayTonKawa'),
            ],
          ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),



      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF2c3e50),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: controller.products.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ProductTile(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
            ),
        ],
      ),
    );
  }   
}




/*class _HomePageState extends State<HomePage> {

    List<Product> ? _products;
    bool _isLoading = true;

    @override
    void initState() {
      super.initState();
      getProduct();
    }

    Future<void> getProduct() async {
      _products = await ProductApi.getProduct();
      setState(() {
        _isLoading = false;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('PayTonKawa'),
            ],
          ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),


      body: ProductCard(
          name: 'Rex Bailey',
          rating: '4.9',
          createdAt: '2023-02-19T13:42:19.010Z',
          thumbnailUrl: 'https://elcafe.fr/wp-content/uploads/2022/01/delonghi-FEB-2961.SB-carre.jpg',
        )


    );
  }
}*/